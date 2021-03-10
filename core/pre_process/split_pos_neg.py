#!/usr/bin/env python3

# import copy

from core.utils.debug_utils import debug_print
from core.configuration.consts import VERBOSE, FIRST_POS_NEG_LAYER
from core.data_structures.Edge import Edge
from core.data_structures.Network import Network


def adjust_layer_after_split_pos_neg(network:Network,
                                     layer_index: int=
                                     FIRST_POS_NEG_LAYER) -> None:
    # debug_print("adjust_layer_after_split_pos_neg")
    cur_layer = network.layers[layer_index]
    next_layer = network.layers[layer_index + 1]
    for node in cur_layer.nodes:
        node.new_out_edges = []
    for next_node in next_layer.nodes:
        next_node.new_in_edges = []
        for cur_node in cur_layer.nodes:
            for out_edge in cur_node.out_edges:
                for suffix in ["", "_pos", "_neg"]:
                    if out_edge.dest + suffix == next_node.name:
                        weight = out_edge.weight
                        edge = Edge(cur_node.name, next_node.name, weight)
                        cur_node.new_out_edges.append(edge)
                        next_node.new_in_edges.append(edge)
        next_node.in_edges = next_node.new_in_edges
        del next_node.new_in_edges
    for node in cur_layer.nodes:
        node.out_edges = node.new_out_edges
        del node.new_out_edges
    if VERBOSE:
        debug_print("after adjust_layer_after_split_pos_neg()")
        print(network)


def preprocess_split_pos_neg(network:Network) -> None:
    """
    split net nodes to nodes with only positive/negative out edges
    preprocess all hidden layers (from last to first), then adjust input
    layer
    """
    if VERBOSE:
        debug_print("preprocess_split_pos_neg()")
    # orig_input_layer = copy.deepcopy(network.layers[0])
    for i in range(len(network.layers) - 2, FIRST_POS_NEG_LAYER, -1):
        network.layers[i].split_pos_neg(network.name2node_map)
    # splited_input_layer = self.layers[0]
    # for node in orig_input_layer.nodes:
    #    node.out_edges = []
    #    for splitted_node in splited_input_layer:
    #        if splitted_node.name[:-4] == node.name:  # suffix=_oos/_neg
    #            edge = Edge(src=node.name, dest=splitted_node.name, weight=1.0)
    #            node.out_edges.append(edge)
    #            splitted_node.in_edges.append(edge)

    network.generate_name2node_map()
    # print(self)
    adjust_layer_after_split_pos_neg(network, layer_index=FIRST_POS_NEG_LAYER)

