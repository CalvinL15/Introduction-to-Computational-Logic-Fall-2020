劉益瑋 B06902100 
HW5 - Intro to Computational Logic

How to run the code (NuSMV 2.6.0):

1. In the terminal, type the command: “NuSMV -int” to run NuSMV
2. Use the command: read_model -i “filename.smv”, the file has to be in the current directory
3. Finally, use these following commands in order: 
	flatten_hierarchy
	encode_variables
	build_model
	check_ltlspec

The command check_ltlspec will perform model checking of the LTL formulas and check the correctness of the code.

Other commands that I've found interesting: print_reachable_states , print_bdd_stats
