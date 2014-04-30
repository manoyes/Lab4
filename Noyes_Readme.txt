
================================================
To "enable" general instruction tests in Matthew Noyes's implementation, the following steps must be taken:

* In "Instruction_memory.v", ensure that "parameter filename" is set to "All_inst.txt"
* In "RegFile.v", ensure that the initial datastore values listed under "These register values are used for 
  testing the instructions (except for beq, jr and jal)" (lines 50 to 65) are *uncommented*, while lines 71
  to 86 are *commented out*

To "enable" the factorial test in Matthew Noyes's implementation, the following steps must be taken:

* In "Instruction_memory.v", ensure that "parameter filename" is set to "factorial.txt"
* In "RegFile.v", ensure that the initial datastore values listed under "These values are used for 
  the factorial bonus" (lines 71 to 86) are *uncommented*, while lines 50 to 65 are *commented out*

================================================

Set the clock time to 20 ns.

For the general instruction case, you can use Ahmed's Readme to view the testing commands and compare output.
	- Note that register outputs are displayed as unsigned numbers, so a positive decimal output may be
	- equivalent to a negative decimal output in binary (as with the implemented NOR test).

For the factorial case, set the simulation time to 1760 ns to view the final output.

================================================