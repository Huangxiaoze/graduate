import sys
sys.path.append("/PRODeep")
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
from core.nnet.read_nnet import network_from_nnet_file
from core.abstraction.naive import abstract_network
from core.abstraction.alg2 import heuristic_abstract_alg2
from core.abstraction.random_abstract import heuristic_abstract_random
# from core.abstraction.clustering_abstract import \
#     heuristic_abstract_clustering
from core.utils.marabou_query_utils import reduce_property_to_basic_form, get_query
from core.refinement.refine import refine


def abstract(net, abstraction_type, abstraction_sequence, property_id=consts.PROPERTY_ID, verbose=consts.VERBOSE
):
    net = copy.deepcopy(net)
    # print(net, abstraction_type, abstraction_sequence, property_id)
    test_property = get_test_property_acas(property_id)
    dynamically_import_marabou(query_type=test_property["type"])

    # for i in range(len(test_property["output"])):
    #     test_property["output"][i][1]["Lower"] = lower_bound

    net, test_property = reduce_property_to_basic_form(network=net, test_property=test_property)
    print("==========================>reduce", net.get_general_net_data())

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
        print("unknown abstraction")
        raise NotImplementedError("unknown abstraction")
    print("ABSTRACT END.......................................")
    return net

def verify_without_ar(net, property_id=consts.PROPERTY_ID):
    print("query using vanilla Marabou")
    return "hello, world"
    test_property = get_test_property_acas(property_id)
    dynamically_import_marabou(query_type=test_property["type"])
    net, test_property = reduce_property_to_basic_form(network=net, test_property=test_property)
    t0 = time.time()
    vars1, stats1, query_result = get_query(
        network=net,
        test_property=test_property,
        verbose=consts.VERBOSE
    )
    t1 = time.time()
    # time to check property on net with marabou
    marabou_time = t1 - t0
    print(f"query time = {marabou_time}")

    res = {
        "net_name" : nnet_filename,
        "property_id" : property_id,
        "query_result" : query_result,
        "orig_query_time" : marabou_time,
        "net_data" : net.get_general_net_data(),
    }
    print(res)
    return json.dumps(res)


def verify_with_ar(net, refinement_type, abstraction_type, refinement_sequence,
                      abstraction_sequence, property_id=consts.PROPERTY_ID,
                      verbose=consts.VERBOSE
    ):
    try:
        net = copy.deepcopy(net)
        print(refinement_type, abstraction_type, refinement_sequence,
              abstraction_sequence, property_id)
        # mechanism is marabou_with_ar
        test_property = get_test_property_acas(property_id)
        dynamically_import_marabou(query_type=test_property["type"])

        net, test_property = reduce_property_to_basic_form(network=net, test_property=test_property)
        orig_net = copy.deepcopy(net)

        t2 = time.time()
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
            print("unknown abstraction")
            raise NotImplementedError("unknown abstraction")
        abstraction_time = time.time() - t2
        print("abstraction_time consume: ", abstraction_time)

        num_of_refine_steps = 0
        ar_times = []
        ar_sizes = []
        refine_sequence_times = []
        spurious_examples = []
        while True:  # CEGAR / CETAR method
            t4 = time.time()
            vars1, stats1, query_result = get_query(
                network=net, test_property=test_property,
                verbose=consts.VERBOSE
            )
            t5 = time.time()
            ar_times.append(t5 - t4)
            ar_sizes.append(net.get_general_net_data()["num_nodes"])
            # if verbose:
            print("query time after A and {} R steps is {}".format(num_of_refine_steps, t5-t4))
            debug_print(net.get_general_net_data())
            print('+'*100)
            print(query_result)
            print("+"*100)
            if query_result == "UNSAT":
                # if always y'<3.99 then also always y<3.99
                if verbose:
                    print("UNSAT (finish)")
                break
            if query_result == "SAT":
                if verbose:
                    print("SAT (have to check example on original net)")
                    print(vars1)
                # debug_print(f'vars1={vars1}')
                # st = time.time()
                # orig_net_output = orig_net.evaluate(vars1)
                # print("evaluate: {}".format(time.time() - st))
                # st = time.time()
                orig_net_output = orig_net.speedy_evaluate(vars1)
                # print(f"orig_net_output={orig_net_output}")
                # print(f"orig_net.name2node_map={orig_net.name2node_map}")
                # print("speedy evaluate: {}".format(time.time() - st))
                nodes2variables, variables2nodes = orig_net.get_variables()
                # we got y'>3.99, check if also y'>3.99 for the same input
                if is_satisfying_assignment(network=orig_net,
                                            test_property=test_property,
                                            output=orig_net_output,
                                            variables2nodes=variables2nodes):
                    if verbose:
                        print("property holds also in orig - SAT (finish)")
                    break  # also counter example for orig_net
                else:
                    spurious_examples.append(vars1)
                    t_cur_refine_start = time.time()
                    if verbose:
                        print("property doesn't holds in orig - spurious example")
                    num_of_refine_steps += 1
                    if verbose:
                        print("refine step #{}".format(num_of_refine_steps))
                    # refine until all spurious examples are satisfied
                    # since all spurious examples are satisfied in the original
                    # network, the loop stops until net will be fully refined
                    refinement_sequences_counter = 0
                    while True:
                        refinement_sequences_counter += 1
                        # print(f"refinement_sequences_counter={refinement_sequences_counter}")
                        if refinement_type == "cegar":
                            debug_print("cegar")
                            net = refine(network=net,
                                         sequence_length=refinement_sequence,
                                         example=vars1)
                        else:
                            debug_print("weight_based")
                            net = refine(network=net,
                                         sequence_length=refinement_sequence)
                        # after refining, check if the current spurious example is
                        # already not a counter example (i.e. not satisfied in the
                        # refined network). stop if not satisfied, continue if yes
                        net_output = net.speedy_evaluate(vars1)
                        # print(f"net_output={net_output}")
                        # print(f"net.name2node_map={net.name2node_map}")
                        nodes2variables, variables2nodes = net.get_variables()
                        if not is_satisfying_assignment(
                                network=net,
                                test_property=test_property,
                                output=net_output,
                                variables2nodes=variables2nodes):
                            break
                    t_cur_refine_end = time.time()
                    refine_sequence_times.append(t_cur_refine_end - t_cur_refine_start)

        t3 = time.time()

        # time to check property on net with marabou using CEGAR
        total_ar_time = t3 - t2
        if verbose:
            print("ar query time = {}".format(total_ar_time))

        # time to check property on the last network in CEGAR
        last_net_ar_time = t3 - t4
        if verbose:
            print("last ar net query time = {}".format(last_net_ar_time))

        res = {
            "property_id" : property_id,
            "abstraction_time" : abstraction_time,
            "query_result" : query_result,
            "num_of_refine_steps" : num_of_refine_steps,
            "total_ar_query_time" : total_ar_time,
            "ar_times" : ar_times,
            "ar_sizes" : ar_sizes,
            "refine_sequence_times" : refine_sequence_times,
            "last_net_data" : net.get_general_net_data(),
            "last_query_time" : last_net_ar_time
        }
        return json.dumps(res)
    except Exception as e:
        print("exception occur", e)

