#!/usr/bin/env python3

from typing import List

from core.data_structures.Network import Network
from core.refinement.step import split_back


def refine(network:Network, sequence_length:int=1, visualize:bool=False, **kws):
    """
    refine @network by applying @sequence_length refinement steps
    :param network: Network to refine
    :param sequence_length: Int, number of refinement steps to apply
    :param visualize: Bool visualization flag (do show net after refine?)
    :param kws: optional Dict, may include "example" keyword in case of cegar or
    be None in case of cetar
    :return: refined Network
    """
    # use huristics to get best test_refinement sequence
    r_sequence = get_refinement_sequence(network=network,
                                         sequence_len=sequence_length,
                                         **kws)
    # print("best {} test_refinement steps are: {}".format(sequence_length,
    #                                                      r_sequence))
    # given test_refinement sequence, actually do test_refinement
    for part in r_sequence:
        split_back(network, part)
        # debug_print("after split_back({})".format(part))
        if visualize:
            network.visualize(title="after refine {}".format(part))
    network.biases = network.generate_biases()
    network.weights = network.generate_weights()
    return network

def get_refinement_sequence(network, sequence_len=1, **kws) -> List[float]:
    """
    huristic function, guess the best test_refinement sequence
    1) a.t. CETAR method, choose max-lossy parts:
    on each iteration, the "most lossy" part in union node will be splitted
    2) a.t. CEGAR method, choose max-lossy parts a.t. counter example:
    use the values of network nodes in a counter example as multipliers of
    the "loss" of each part in the CETAR method
    run example on network and split the part which most changed the result

    @sequence_len - indicates the number of top test_refinement steps to return
    @kws - dict that include "example" key in case of h2 and None otherwise
    @example - marabou's counter example (node names instead of variables)
    """
    if kws is not None and "example" in kws.keys():
        # h2 - cegar method
        example = kws.get("example")
    else:
        # h1 - max-loss method
        example = {}
    part2loss_map = network.get_part2loss_map(example=example)
    top_part_loss = sorted(part2loss_map.items(),
                           key=lambda x:x[1],
                           reverse=True
                          )[:sequence_len]
    # p2l stands for "part2loss", pl[0] is part name
    return [p2l[0] for p2l in top_part_loss]
