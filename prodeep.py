#/usr/bin/python3

"""
run one experiment - query cegarabou engine:
calculate if property (p1 or p2) is sat/unsat in a net which is represented by a given .nnet formatted file
write to result file the result of the query and data on the calculation process - times, sizes, etc. .

usage: python3 -f <nnet_filename> -a <abstraction_type> -r <test_refinement type> -e <epsilon value> -l <lower_bound> -o? -p?
example of usage: python3 -f ACASXU_run2a_1_8_batch_2000.nnet -a heuristic -r cegar -e 1e-5 -l 25000 -o -p -s 100
"""

# external imports

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
from core.utils.debug_utils import debug_print
from core.utils.verification_properties_utils import (
    get_test_property_acas, is_satisfying_assignment, TEST_PROPERTY_ACAS
)
from core.nnet.read_nnet import network_from_nnet_file, save_network_in_json_format
from core.abstraction.naive import abstract_network
from core.abstraction.alg2 import heuristic_abstract_alg2
from core.abstraction.random_abstract import heuristic_abstract_random
# from core.abstraction.clustering_abstract import \
#     heuristic_abstract_clustering
from core.utils.marabou_query_utils import reduce_property_to_basic_form, get_query
from core.refinement.refine import refine


def test():
    # test_property = get_test_property_acas(property_id)
    # dynamically_import_marabou(query_type=test_property["type"])

    # for i in range(len(test_property["output"])):
    #     test_property["output"][i][1]["Lower"] = lower_bound
    net = network_from_nnet_file("../nnet/ACASXU_run2a_1_1_batch_2000.nnet")
    save_network_in_json_format(net, "test.json")
    # net, test_property = reduce_property_to_basic_form(network=net, test_property=test_property)

if __name__ == "__main__":
    print("hello")
    test()
