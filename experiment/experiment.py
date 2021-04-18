from core.prodeep import prodeep
import copy
import json
from core.nnet.read_nnet import (network_from_nnet_file, network2rlv)


if __name__ == "__main__":
	with open('./experiment/parameter.json', 'r') as f:
		parameter = json.loads(f.read())
		print(parameter)

	parameter['filepath'] = "Examples/test/ReluplexFiles/nnet/ACASXU_run2a_{}_batch_2000.nnet".format(parameter['file'])

	# verify with ar
	net = network_from_nnet_file(parameter['filepath'])

	abstract_net, orig_net, test_property, output = prodeep.abstract(net, json.dumps(parameter))

	print(output)

	output = prodeep.verify_with_ar(abstract_net, orig_net, test_property, parameter['refinement_type'], parameter['abstract_type'], parameter['refinement_sequence'], parameter['abstraction_sequence']);

	print(output)



	print('-' * 50)
	# verify without ar
	output = prodeep.verify_without_ar(net, json.dumps(parameter))
	print(output)
	print('+' * 50)
	# planet with ar

	output = prodeep.planet_with_ar(json.dumps(parameter))

	print(output)
	print('@' * 50)

	# planet without ar
	output = prodeep.planet_without_ar(json.dumps(parameter))
	print(output)
	print('$' * 50)