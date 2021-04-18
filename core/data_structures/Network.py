#!/usr/bin/env python3

import copy
import numpy as np
from typing import Tuple, Dict, List, TypeVar
AnyType = TypeVar('T')

import import_marabou
from maraboupy import MarabouNetworkNNet

from core.data_structures.Edge import Edge
from core.data_structures.ARNode import ARNode
from core.data_structures.Layer import Layer
from core.configuration.consts import VERBOSE


class Network:
    """
    This class represents a neural network that supports abstraction and
    refinement steps in the process of verification. A Net has list of
    Layers and some metadata about the ARNodes in it. The major part of the
    functionality in the class deals with the metadata manipulation, but there
    are also some functions for input evaluation and for interfacing with the
    verifier, Marabou, and for generating Network from .nnet file
    """
    def __init__(self, layers:List, weights:List=None,
                 biases:List=None, acasxu_net:MarabouNetworkNNet=None):
        self.layers = layers
        self.acasxu_net = acasxu_net
        self.orig_layers = None
        self.orig_name2node_map = None

        # map from name of node to its instance
        self.name2node_map = None
        self.generate_name2node_map()
        # save first map to extract valid refinements of specific test_abstraction
        self.initial_name2node_map = copy.deepcopy(self.name2node_map)
        # self.visualize(title="init")
        self.weights = self.generate_weights() if weights is None else weights
        self._biases = self.generate_biases() if biases is None else biases
        self.biases = self.generate_biases()

    def generate_weights(self) -> List:
        """
        :return: matrix of incoming edges' weights in the network
        The matrix includes the incoming edges' weights of the nodes in each layer,
        from layer 1 (first hidden layer) to output layer.
        For example, weights[0] includes the incoming edges' weights of layer 1 (first hidden layer),
        i.e the weights from layer 0 to layer 1.
        """
        if len(self.layers) < 2:
            raise NotImplementedError("try to extract weights to network with not enough layers")
        # maybe can be used in future...
        # the difference between _weights and weights is that weights include 0-weighted edges and _weights not.
        # _weights = []
        # for layer in self.layers[1:]:
        #     layer_weights = []
        #     for node in layer.nodes:
        #         # list of weights of in_edges of the node. initialize with zeros and fill
        #         node_weights = []
        #         for in_edge in node.in_edges:
        #             node_weights.append(in_edge.weight)
        #         layer_weights.append(node_weights)
        #     _weights.append(layer_weights)

        weights = []
        for prev_layer_index, layer in enumerate(self.layers[1:]):
            prev_layer = self.layers[prev_layer_index]
            # map from name of node in previous layer to its index (in the previous layer)
            prev_layer_name2index = {node.name: index for (index, node) in enumerate(prev_layer.nodes)}
            layer_weights = []
            for node in layer.nodes:
                # list of weights of in_edges of the node. initialize with zeros and fill
                node_weights = [0.0] * len(self.layers[prev_layer_index].nodes)
                for in_edge in node.in_edges:
                    src_index = prev_layer_name2index[in_edge.src]
                    node_weights[src_index] = in_edge.weight
                layer_weights.append(node_weights)
            weights.append(layer_weights)
        # print(weights)
        # print(_weights)
        return weights

    def generate_biases(self) -> List:
        """
        :return: matrix of biases of the network
        The matrix includes the biases of the nodes in each layer except input layer,
        i.e. biases from layer 1 (first hidden layer) to output layer.
        """
        if len(self.layers) < 2:
            raise NotImplementedError("try to extract biases to network with not enough layers")
        biases = []
        for layer in self.layers[1:]:
            layer_biases = []
            for node in layer.nodes:
                layer_biases.append(node.bias)
            biases.append(layer_biases)
        return biases

    def __eq__(self, other:AnyType, verbose:bool=VERBOSE) -> bool:
        if self.get_general_net_data() != other.get_general_net_data():
            if verbose:
                print("self.get_general_net_data() ({}) != other.get_general_net_data() ({})".format(
                    self.get_general_net_data(), other.get_general_net_data()))
            return False
        for i, layer in enumerate(self.layers):
            if layer != other.layers[i]:
                if verbose:
                    print("self.layers[{}] != other.layers[{}]".format(i, i))
                return False
        return True

    def layer_index2layer_size(self) -> Dict:
        return {i: len(self.layers[i].nodes) for i in range(len(self.layers))}

    def get_general_net_data(self) -> Dict:
        """
        return dict with general data on the network, of the following form:
        {
            "layer_sizes": dict from layer_index to layer size
            "num_nodes": total number of nodes in net
            "num_layers": number of layers
            "num_hidden_layers": number of hidden layers
        }
        """
        layer_index2layer_size = self.layer_index2layer_size()
        num_nodes = sum([size for (ind, size) in layer_index2layer_size.items()])
        num_layers = len(layer_index2layer_size)
        num_hidden_layers = sum([l.type_name == "hidden" for l in self.layers])
        return {
            "layer_sizes": layer_index2layer_size,
            "num_nodes": num_nodes,
            "num_layers": num_layers,
            "num_hidden_layers": num_hidden_layers
        }

    def get_variable2layer_index(self, variables2nodes:Dict) -> Dict:
        variable2layer_index = {}
        node2layer_map = self.get_node2layer_map()
        for variable, node in variables2nodes.items():
            if node.endswith("_b") or node.endswith("_f"):
                node = node[:-2]  # remove suffix
            variable2layer_index[variable] = node2layer_map[node]
        return variable2layer_index

    def evaluate(self, input_values:Dict) -> Dict:
        # print("input_values={}".format(input_values.items()))
        nodes2variables, variables2nodes = self.get_variables()
        # variable2layer_index = self.get_variable2layer_index(variables2nodes)
        cur_node2val = {}
        for node in self.layers[0].nodes:
            var = nodes2variables[node.name]
            cur_node2val[node.name] = input_values[var]
        for i, cur_layer in enumerate(self.layers[1:]):
            # print("evaluate():\t", i, cur_node2val.items())
            prev_node2val = cur_node2val
            layer_index = i + 1
            prev_layer = self.layers[i]
            cur_node2val = {node.name: node.bias for node in cur_layer.nodes}
            # prev_node2val = {node.name: 0.0 for node in prev_layer.nodes}

            for node in prev_layer.nodes:
                for out_edge in node.out_edges:
                    # prev_node2val include names with or without "_b" suffix
                    # if out_edge.src in prev_node2val:
                    if layer_index == 1:
                        src_val = prev_node2val[out_edge.src]
                    else:
                        src_val = prev_node2val[out_edge.src + "_f"]
                    add_val = out_edge.weight * src_val
                    cur_node2val[out_edge.dest] += add_val
            # apply activation function (from x_ij_b to x_ij_f)
            # don't apply to output layer
            if layer_index < len(self.layers) - 1:
                # print("layer_index={}, cur_layer is not output layer".format(layer_index))
                # print("before activation, cur_node2val.items() = {}".format(cur_node2val.items()))
                activation_vals = {}
                for k, v in cur_node2val.items():
                    activation_func = self.name2node_map[k].activation_func
                    activation_vals[k + "_f"] = activation_func(v)
                cur_node2val.update(activation_vals)
                # print("after activation, cur_node2val.items() = {}".format(cur_node2val.items()))

            # cur_values = layer.evaluate(cur_values, nodes2variables, next,
            #                            variables2nodes, variable2layer_index)
        return cur_node2val

    def speedy_evaluate(self, input_values:Dict) -> List:
        assert self.weights is not None
        assert self.biases is not None
        input_list = [v for (k, v) in sorted(input_values.items(), key=lambda x: x[0])[:len(self.layers[0].nodes)]]
        # if net was generated by net_from_nnet_file() func
        # and haven't been abstracted yet, use acasxu evaluation
        # if hasattr(self, "acasxu_net"):
        #     input_list = np.array(input_list).reshape((1, -1))
        #     return self.acasxu_net.evaluate(input_list)
        current_inputs = np.array(input_list)
        for layer in range(len(self.layers) - 2):
            # assumes that activation function is relu (otherwise replace np.maximum with something else)
            # print(layer)
            # print("speedy_evaluate():\t{}\n{}".format(layer, current_inputs))
            # print(self.weights[layer])
            current_inputs = np.maximum(np.dot(self.weights[layer], current_inputs) + self.biases[layer], 0.0)
        # print("speedy_evaluate():\t{}\n{}".format(layer, current_inputs))
        outputs = np.dot(self.weights[-1], current_inputs) + self.biases[-1]
        # print("speedy_evaluate()\t outputs:\n{}".format(current_inputs))
        return outputs

    def generate_name2node_map(self) -> None:
        name2node_map = {}
        for layer in self.layers:
            for node in layer.nodes:
                name2node_map[node.name] = node
        self.name2node_map = name2node_map

    def remove_node(self, node:ARNode, layer_index:float) -> None:
        layer = self.layers[layer_index]
        for in_edge in node.in_edges:
            src_node = self.name2node_map[in_edge.src]
            # less effective
            # src_node.out_edges = [oe for oe in src_node.out_edges if oe != in_edge]
            if src_node.out_edges:
                for i, oe in enumerate(src_node.out_edges):
                    if oe == in_edge:
                        break
                del (src_node.out_edges[i])
            del in_edge
        for out_edge in node.out_edges:
            dest_node = self.name2node_map[out_edge.dest]
            # less effective
            # dest_node.in_edges = [ie for ie in dest_node.in_edges if ie != out_edge]
            if dest_node.in_edges:
                for i, ie in enumerate(dest_node.in_edges):
                    if ie == out_edge:
                        break
                del (dest_node.in_edges[i])
            del out_edge
        # less effective
        # layer.nodes = [n for n in layer.nodes if n != node]
        for i, cur_node in enumerate(layer.nodes):
            if cur_node == node:
                break
        del layer.nodes[i]
        del node

    def get_part2loss_map(self, example:Dict={}) -> Dict:
        part2loss = {}
        nodes2edge_between_map = self.get_nodes2edge_between_map()
        for layer in self.layers[2:]:
            layer_part2loss_map = \
                self.get_layer_part2loss_map(self.orig_name2node_map,
                                             nodes2edge_between_map,
                                             example)
            part2loss.update(layer_part2loss_map)
        return part2loss

    def get_layer_part2loss_map(self,
                                orig_name2node_map:Dict,
                                nodes2edge_between_map:Dict,
                                example:Dict={}) -> Dict:
        part2loss = {}
        part2node = self.get_part2node_map()
        nodes2variables, variables2nodes = self.get_variables()
        for node_name in self.name2node_map:
            parts = node_name.split("+")
            if len(parts) <= 1:
                continue
            for part in parts:
                part2loss.setdefault(part, 0.0)
                orig_part_node = orig_name2node_map[part]
                for edge in orig_part_node.out_edges:
                    dest_union = part2node[edge.dest]
                    abstract_edge = nodes2edge_between_map[(node_name,
                                                            dest_union)]
                    diff = abs(edge.weight - abstract_edge.weight)
                    node_var = nodes2variables.get(node_name + "_f",
                                                   nodes2variables.get(node_name + "_b",
                                                                       nodes2variables.get(node_name)))
                    diff *= example.get(node_var, 1.0)
                    part2loss[part] += diff
        return part2loss
        
    def get_nodes2edge_between_map(self) -> Dict:
        nodes2edge_between_map = {}
        for layer in self.layers:
            for node in layer.nodes:
                for edge in node.out_edges:
                    nodes2edge_between_map[(edge.src, edge.dest)] = edge
        return nodes2edge_between_map

    def get_part2node_map(self) -> Dict:
        part2node_map = {}
        for layer in self.layers:
            for node in layer.nodes:
                parts = node.name.split("+")
                for part in parts:
                    part2node_map[part] = node.name
        return part2node_map

    def get_node2layer_map(self) -> Dict:
        """
        returns map from node name to layer index (in self.layers)
        """
        node2layer_map = {}
        for i, layer in enumerate(self.layers):
            for node in layer.nodes:
                node2layer_map[node.name] = i
        return node2layer_map


    @staticmethod
    def get_next_nodes(current_values:List) -> List:
        next_nodes = set([])
        for node in current_values:
            for edge in node.out_edges:
                next_nodes.add(edge.dest)
        return list(next_nodes)

    def get_part2example_change(self, example:Dict) -> Dict:
        """
        run example, calculate difference in each node between its outputed
        value and the original netework outputed value,
        @example: a dict from node name no value
        @return map from part to the sum of differences
        """
        part2diffs = {}
        cur_layer_values = example
        while True:
            next_layer_nodes = self.get_next_nodes(cur_layer_values)
            if not next_layer_values:
                break
            next_layer_values = {name: 0.0 for name in next_layer_nodes}
            for node_name in cur_layer_values.keys():
                node = self.name2node_map[node_name]
                for edge in node.out_edges:
                    cur_value = cur_layer_values[node.name]
                    next_layer_values[edge.dest] += edge.weight * cur_value
            for node, val in next_layer_values.items():
                part2diffs[node] = val
            cur_layer_values = next_layer_values
        return part2diffs

    def get_variables(self, property_type:str="basic") -> Tuple[Dict, Dict]:
        nodes2variables = {}
        variables2nodes = {}
        var_index = 0
        is_acas_xu_conjunction = (property_type == "acas_xu_conjunction")
        # is_adversarial = property_type == "adversarial"
        for l_index, layer in enumerate(self.layers):
            for node in layer.nodes:
                if layer.type_name in ["input", "output"]:
                    nodes2variables[node.name] = var_index
                    variables2nodes[var_index] = node.name
                    var_index += 1
                else:  # hidden layer, all nodes with relu activation
                    if is_acas_xu_conjunction and l_index == len(self.layers)-3:
                        # prev output layer, no relu
                        suffices = ["_b"]
                    # elif is_adversarial and l_index == len(self.layers)-2:
                    #     # prev output layer, no relu
                    #     suffices = ["_b"]
                    else:
                        suffices = ["_b", "_f"]
                    for suffix in suffices:
                        nodes2variables[node.name + suffix] = var_index
                        variables2nodes[var_index] = node.name + suffix
                        var_index += 1
        return nodes2variables, variables2nodes

    def get_large(self) -> float:
        # some silly heuristic to get upper bound for value in the network
        # without returning too big number
        # in each layer multiply the result in the max absolute value
        # of an out edge
        large = 1.0
        for layer in self.layers:
            for node in layer.nodes:
                out_weights = [abs(edge.weight) for edge in node.out_edges]
                large *= max(out_weights, default=1.0)
        return min(20, "large = {}\n\n".format(large))

    def __str__(self) -> str:
        s = ""
        net_data = self.get_general_net_data()
        for k, v in net_data.items():
            s += "{}: {}\n".format(k, v)
        s += "\n"
        s += "\n\n".join(layer.__str__() for layer in self.layers)
        print("==> bias", self.biases)
        print('-'*100)
        print('==> weight ', self.weights)
        return s
