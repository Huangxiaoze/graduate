#!/usr/bin/env python3

import copy

from core.configuration.consts import VERBOSE
from core.utils.debug_utils import debug_print
from core.data_structures.Network import Network
from core.data_structures.Edge import Edge
from core.visualization.visualize_network import visualize_network
from .split_pos_neg import preprocess_split_pos_neg
from .split_inc_dec import preprocess_split_inc_dec


def is_there_edge_between(node_1, node_2):
    for out_edge in node_1.out_edges:
        if out_edge.src == node_1.name and out_edge.dest == node_2.name:
            return True
    return False


def fill_zero_edges(network:Network) -> None:
    for i,layer in enumerate(network.layers[:-1]):
        # if i == 2:
        #     import IPython
        #     IPython.embed()
        for node_1 in layer.nodes:
            for node_2  in network.layers[i+1].nodes:
                if not is_there_edge_between(node_1, node_2):
                    zero_edge = Edge(src=node_1.name, dest=node_2.name, weight=0.0)
                    node_1.out_edges.append(zero_edge)
                    node_2.in_edges.append(zero_edge)


def preprocess(network:Network) -> None:
    """
    pre-process networdk in two stages: split to pos/neg, then split to inc/dec
    :param network: Network before pre-process (nodes without special types)
    :return: Network after pre-process (nodes with special types pos/neg, inc/dec)
    """
    # split to pos/neg
    preprocess_split_pos_neg(network)
    # fill_zero_edges(network)
    # from core.visualization.visualize_network import visualize_network
    # split to inc/dec
    preprocess_split_inc_dec(network)
    # fill_zero_edges(network)
    if VERBOSE:
        debug_print("after preprocess")
    # visualize_network(network_layers=network.layers, title="after preprocess w/o zero edges")
    fill_zero_edges(network)

        # print(network)
        # self.visualize(title="after preprocess")
    # visualize_network(network_layers=network.layers, title="after preprocess w/ zero edges", out_image_path="/home/xiaoze/Desktop/images/1.png", debug=True)

    # generate a copy of the original pre-processed network for later use
    network.orig_layers = copy.deepcopy(network.layers)
    network.orig_name2node_map = copy.deepcopy(network.name2node_map)
    network.weights = network.generate_weights()
    network.biases = network.generate_biases()
