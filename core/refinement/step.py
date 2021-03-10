#!/usr/bin/env python3

#pylint: disable=E0601
from typing import AnyStr

from core.utils.debug_utils import debug_print
from core.data_structures.Edge import Edge
from core.data_structures.ARNode import ARNode
from core.data_structures.Network import Network
from core.utils.ar_utils import calculate_weight_of_edge_between_two_part_groups
from core.pre_process.pre_process import fill_zero_edges


def split_back(network:Network, part:AnyStr) -> None:
    """
    implement the refinement step. split back part from the union node it was
    grouped into into a separated node
    :param network: Network
    :param part: Str of the name of the original node that is part of the union
    """
    # assume that layer_index is in [2, ..., L-1] (L = num of layers)
    try:
        layer_index = int(part.split("_")[1])
    except IndexError:
        debug_print("IndexError in core.test_refinement.step.split_back()")
        import IPython
        IPython.embed()
    layer = network.layers[layer_index]
    next_layer = network.layers[layer_index + 1]
    prev_layer = network.layers[layer_index - 1]
    part2node_map = network.get_part2node_map()
    union_node = network.name2node_map[part2node_map[part]]
    parts = union_node.name.split("+")
    other_parts = [p for p in parts if p != part]
    if not other_parts:
        return
    part_node = ARNode(name=part,
                       ar_type=union_node.ar_type,
                       activation_func=union_node.activation_func,
                       in_edges=[],
                       out_edges=[],
                       bias=network.orig_name2node_map[part].bias
                       )
    bias = sum([network.orig_name2node_map[other_part].bias
                for other_part in other_parts])
    other_parts_node = ARNode(name="+".join(other_parts),
                              ar_type=union_node.ar_type,
                              activation_func=union_node.activation_func,
                              in_edges=[],
                              out_edges=[],
                              bias=bias
                              )
    splitting_nodes = [part_node, other_parts_node]

    for splitting_node in splitting_nodes:
        # print("splitting_node.name={}".format(splitting_node.name))
        for next_layer_node in next_layer.nodes:
            group_a = splitting_node.name.split("+")
            group_b = next_layer_node.name.split("+")
            # print("call 1 - group_a")
            # print(group_a)
            # print("call 1 - group_b")
            # print(group_b)
            out_edge_weight = calculate_weight_of_edge_between_two_part_groups(
                network=network, group_a=group_a, group_b=group_b)

            if out_edge_weight is not None:
                out_edge = Edge(splitting_node.name,
                                next_layer_node.name,
                                out_edge_weight)
                splitting_node.out_edges.append(out_edge)
                next_layer_node.in_edges.append(out_edge)
            # fill_zero_edges(network)
        for prev_layer_node in prev_layer.nodes:
            group_a = prev_layer_node.name.split("+")
            group_b = splitting_node.name.split("+")
            # print("call 2 - group_a")
            # print(group_a)
            # print("call 2 - group_b")
            # print(group_b)
            in_edge_weight = calculate_weight_of_edge_between_two_part_groups(
                network=network, group_a=group_a, group_b=group_b)
            if in_edge_weight is not None:
                in_edge = Edge(prev_layer_node.name,
                               splitting_node.name,
                               in_edge_weight)
                splitting_node.in_edges.append(in_edge)
                prev_layer_node.out_edges.append(in_edge)
            # fill_zero_edges(network)
        layer.nodes.append(splitting_node)
        fill_zero_edges(network)
    network.remove_node(union_node, layer_index)
    network.generate_name2node_map()
