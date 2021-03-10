print("Hello")
import sys
sys.path.append("/CEGAR_NN")
import os
import json
import copy
import time
import argparse
import pandas as pd

# internal imports
from import_marabou import dynamically_import_marabou
from core.configuration import consts
from experiments.consts import BEST_CEGARABOU_METHODS
from core.utils.debug_utils import debug_print
from core.utils.verification_properties_utils import (
    get_test_property_acas, is_satisfying_assignment, TEST_PROPERTY_ACAS
)

#print("Word")

def abstract(nnet_filename, abstraction_type, abstraction_sequence, property_id=consts.PROPERTY_ID, verbose=consts.VERBOSE
):
    test_property = get_test_property_acas(property_id)
    dynamically_import_marabou(query_type=test_property["type"])
    from core.nnet.read_nnet import network_from_nnet_file
    from core.abstraction.naive import abstract_network
    from core.abstraction.alg2 import heuristic_abstract_alg2
    from core.abstraction.random_abstract import heuristic_abstract_random
    # from core.abstraction.clustering_abstract import \
    #     heuristic_abstract_clustering
    from core.utils.marabou_query_utils import reduce_property_to_basic_form, get_query
    from core.refinement.refine import refine

    # for i in range(len(test_property["output"])):
    #     test_property["output"][i][1]["Lower"] = lower_bound
    net = network_from_nnet_file(fullname)
    print(f"size={len(net.layers)}")

    net, test_property = reduce_property_to_basic_form(network=net, test_property=test_property)

    print("ABSTRACT START......................................")
    print("use {} abstraction type".format(abstraction_type))
    if abstraction_type == "complete":
        net = abstract_network(net)
    elif abstraction_type == "heuristic_alg2":
        net = heuristic_abstract_alg2(
            network=net,
            test_property=test_property,
            sequence_length=abstraction_sequence
        )
    elif abstraction_type == "heuristic_random":
        net = heuristic_abstract_random(
            network=net,
            test_property=test_property,
            sequence_length=abstraction_sequence
        )
    # elif abstraction_type == "heuristic_clustering":
    #     net = heuristic_abstract_clustering(
    #         network=net,
    #         test_property=test_property,
    #         sequence_length=abstraction_sequence
    #     )
    else:
        raise NotImplementedError("unknown abstraction")
    print("ABSTRACT END.......................................")
    return net
