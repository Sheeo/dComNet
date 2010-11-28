.method main
.args 1
	bipush 4
	bipush 5
	ishl      // 4 << 5 = 2^7 = 128
	pop

	bipush 120
	bipush 3
	iushr     // 120 >> 3 = 0b01111000 >> 3 = 0b0001111 = 15
	pop
	bipush -4
	bipush 1
	iushr     // unsigned shift: -4 >> 1 = 0b1111...1100 >> 1 = 0b0111...1110 = 2^32-2
	pop
	bipush -4
	bipush 1
	ishr      // signed shift: -4 >> 1 = 0b1111...1100 >> 1 = 0b1111...1110 = -2
	pop
	bipush 5
	bipush 2
	ishr      // 5 >> 2 = 0b101 >> 2 = 0b001 = 1
	ireturn
