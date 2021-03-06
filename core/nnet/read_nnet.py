#!/usr/bin/env python3

import os
import json
import import_marabou
from maraboupy import MarabouNetworkNNet

from core.configuration.consts import (
    PATH_TO_MARABOU_APPLICATIONS_ACAS_EXAMPLES
)
from core.data_structures.Edge import Edge
from core.data_structures.ARNode import ARNode
from core.data_structures.Layer import Layer
from core.data_structures.Network import Network
from core.utils.activation_functions import relu


def network_from_nnet_file(nnet_filename: str) -> Network:
    """
    generate Net instance which is equivalent to given nnet formatted network
    @nnet_filename fullpath of nnet file, see maraboupy.MarabouNetworkNNet
    under the root dir of git marabou project
    :return: Network object
    """
    # read nnetfile into Marabou Network
    print("network_from_nnet_file")
    acasxu_net = MarabouNetworkNNet.MarabouNetworkNNet(filename=nnet_filename)
    # list of layers, layer include list of nodes, node include list of Edge-s
    # notice the acasxu.weights include weights of input edges
    edges = []  # list of list of list of Edge instances
    # edges[i] is list of list of edges between layer i to layer i+1
    # edges[i][j] is list of out edges from node j in layer i
    # edges[i][j][k] is the k'th out edge of "node" j in "layer" i
    for i in range(len(acasxu_net.layerSizes)-1):
        # add cell for each layer, includes all edges in that layer
        edges.append([])
        for j in range(len(acasxu_net.weights[i])):
            # add cell for each node, includes all edges in that node
            edges[i].append([])
            for k in range(len(acasxu_net.weights[i][j])):
                # acasxu.weights include input edges, so the edge is from the
                # k'th node in layer i to the j'th node in layer i+1
                src = "x_{}_{}".format(i,k)
                dest = "x_{}_{}".format(i+1,j)
                weight = acasxu_net.weights[i][j][k]
                edge = Edge(src=src, dest=dest, weight=weight)
                edges[i][j].append(edge)
                # print(i,j,k,mn.weights[i][j][k])

    # validate sizes
    assert(len(acasxu_net.weights) == len(edges))
    for i in range(len(acasxu_net.layerSizes)-1):
        assert(len(acasxu_net.weights[i]) == len(edges[i]))
        for j in range(len(acasxu_net.weights[i])):
            assert(len(acasxu_net.weights[i][j]) == len(edges[i][j]))
            for k in range(len(acasxu_net.weights[i][j])):
                if acasxu_net.weights[i][j][k] != edges[i][j][k].weight:
                    print("wrong edges: {},{},{}".format(i,j,k))
                    assert False

    nodes = []  # list of list of ARNode instances
    # nodes[i] is list of nodes in layer i
    # nodes[i][j] is ARNode instance of node j in layer i
    name2node_map = {}  # map name to arnode instance, for adding edges later
    for i, layer in enumerate(edges):
        nodes.append([])  # add layer
        for j, node in enumerate(layer):
            for k,edge in enumerate(node):
                src_name = edge.src
                if src_name not in name2node_map.keys():
                    src_arnode = ARNode(name=src_name,
                                        ar_type=None,
                                        in_edges=[],
                                        out_edges=[],
                                        activation_func=relu,
                                        bias=0.0  # assigned later
                                       )
                    nodes[i].append(src_arnode)
                    name2node_map[src_name] = src_arnode

    # add output layer nodes
    # equal to add the next line
    # layer = acasxu_net.weights[len(acasxu_net.layerSizes)-1]
    nodes.append([])
    for j, node in enumerate(layer):
        for k, edge in enumerate(node):
            dest_name = edge.dest
            if dest_name not in name2node_map.keys():
                dest_arnode = ARNode(name=dest_name,
                                     ar_type=None,
                                     in_edges=[],
                                     out_edges=[],
                                     activation_func=relu,
                                     bias=0.0  # assigned later
                                    )
                nodes[i+1].append(dest_arnode)
                name2node_map[dest_name] = dest_arnode

    # after all nodes instances exist, add input and output edges
    for i,layer in enumerate(edges):  # layer is list of list of edges
        for j,node in enumerate(layer):  # node is list of edges
            for k,edge in enumerate(node):  # edge is Edge instance
                #print (i,j,k)
                src_node = name2node_map[edge.src]
                dest_node = name2node_map[edge.dest]
                src_node.out_edges.append(edge)
                dest_node.in_edges.append(edge)

    layers = []
    for i,layer in enumerate(nodes):
        if i == 0:
            type_name = "input"
        elif i == len(acasxu_net.layerSizes) - 1:
            type_name = "output"
        else:
            type_name = "hidden"
        layers.append(Layer(type_name=type_name, nodes=nodes[i]))

    for i, biases in enumerate(acasxu_net.biases):
        layer = layers[i + 1]
        for j, node in enumerate(layer.nodes):
            node.bias = biases[j]
    for i, layer in enumerate(acasxu_net.weights):
        print("layer:", i, " ", len(layer))
    # print(acasxu_net.weights)
    # print("-"*100)
    # print(acasxu_net.biases)
    net = Network(layers=layers, weights=acasxu_net.weights, biases=acasxu_net.biases, acasxu_net=acasxu_net)

    # for i,biases in enumerate(acasxu_net.biases):
        # layer = net.layers[i+1]
        # for j,node in enumerate(layer.nodes):
        #     node.bias = biases[j]
    return net


def get_all_acas_nets(indices=None):
    """
    :param indices: list of indices of nnet files, if None return all
    :return: list of Net objects of acas networks in the relevant indices
    """
    nnet_dir = PATH_TO_MARABOU_APPLICATIONS_ACAS_EXAMPLES
    l = []
    for i,filename in enumerate(os.listdir(nnet_dir)):
        if i+1 not in indices:
            continue
        nnet_filename = os.path.join(nnet_dir, filename)
        l.append(network_from_nnet_file(nnet_filename))
    return l

def get_network_in_json_str(net):
    network_json = net.get_general_net_data()
    network_json['graph'] = {}
    network_json['graph']['number_of_nodes'] = net.get_general_net_data()["num_nodes"]
    network_json['graph']['names'] = []
    network_json['graph']['edges'] = []
    network_json['graph']['name2pos'] = {}
    for i, layer in enumerate(net.layers):
        for j, node in enumerate(layer.nodes):
            network_json['graph']['names'].append(node.name)
            network_json['graph']['name2pos'][node.name] = {"x": i, "y": j}
    for layer in net.layers:
        for node in layer.nodes:
            for edge in node.out_edges:
                network_json['graph']['edges'].append({
                        'from': network_json['graph']['names'].index(edge.src),
                        'to': network_json['graph']['names'].index(edge.dest)
                    })
    return json.dumps(network_json)

def save_network_in_json_format(net, filename):
    print("save_network_in_json_format")
    print("save_network_in_json_format start")
    network_json = net.get_general_net_data()
    network_json['graph'] = {}
    network_json['graph']['number_of_nodes'] = net.get_general_net_data()["num_nodes"]
    network_json['graph']['names'] = []
    network_json['graph']['edges'] = []
    for layer in net.layers:
        for node in layer.nodes:
            network_json['graph']['names'].append(node.name)
    for layer in net.layers:
        for node in layer.nodes:
            for edge in node.out_edges:
                network_json['graph']['edges'].append({
                        'from': network_json['graph']['names'].index(edge.src),
                        'to': network_json['graph']['names'].index(edge.dest)
                    })
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(json.dumps(network_json))


def network2rlv(network, property_, filename):
    with open(filename, 'w') as file_object:
        network_length = len(network.layers)
        for layer_index in range(network_length):
            if layer_index == 0:
                for node in network.layers[layer_index].nodes:
                    file_object.write("Input {}".format(node.name))
                    file_object.write("\n")
            elif layer_index == network_length-1:
                for node in network.layers[layer_index].nodes:
                    file_object.write("Linear {} ".format(node.name))
                    file_object.write("{} ".format(node.bias))
                    for edge in node.in_edges:
                        file_object.write("{} {} ".format(edge.weight, edge.src))
                    file_object.write("\n")
            else:
                for node in network.layers[layer_index].nodes:
                    file_object.write("ReLU {} ".format(node.name))
                    file_object.write("{} ".format(node.bias))
                    for edge in node.in_edges:
                        file_object.write("{} {} ".format(edge.weight, edge.src))
                    file_object.write("\n")
        for index, bound in property_["input"]:
            file_object.write("Assert >= {} 1.0 x_0_{}".format(bound["Upper"],index))
            file_object.write("\n")
            file_object.write("Assert <= {} 1.0 x_0_{}".format(bound["Lower"],index))
            file_object.write("\n")
        for index, bound in property_["output"]:
            #file_object.write("Assert <= {} 1.0 x_{}_{}".format(network_length-1, bound["upper"],index))
            file_object.write("Assert <= {} 1.0 {}".format(bound["Lower"], network.layers[-1].nodes[index].name))
            file_object.write("\n")
