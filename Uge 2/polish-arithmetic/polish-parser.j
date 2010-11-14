.method parsechar
.args 4
.define operator = 1
.define operand1 = 2
.define operand2 = 3
	iload operator
	bipush 47
	isub
	ifeq perform_idiv	// if(operator = /)

	iload operator
	bipush 42
	isub
	ifeq perform_imul	// if(operator = *)
	
	iload operator
	bipush 43
	isub
	ifeq perform_iadd	// if(operator = +)
	
	iload operator
	bipush 45
	isub
	ifeq perform_isub	// if(operator = -)	

	// numbers below here
	iload operator
	bipush 48
	isub
	ireturn				// return number inputted

perform_idiv:
	bipush 120			// objref
	iload operand1
	iload operand2
	idiv
	ireturn

perform_imul:
	bipush 120
	iload operand1
	iload operand2
	imul
	ireturn

perform_iadd
	iload operand1
	iload operand2
	iadd
	ireturn

perform_isub:
	iload operand1
	iload operand2
	isub
	ireturn

