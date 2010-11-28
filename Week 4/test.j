.method main
.args 1
// test normal circumstances

// ishl(4,5) = 4 << 5 = 2^7 = 128
	bipush 4
	bipush 5
	ishl
	pop

// iushr(120,3) = 120 >> 3 = 15
	bipush 120
	bipush 3
	iushr
	pop

// iushr(-4,1) = 0b1111...1100 >> 1 = 0b0111...1110 = 2
	bipush -4
	bipush 1
	iushr
	pop

// ishr(-4,1) = -4 >> 1 = -2
	bipush -4
	bipush 1
	ishr
	pop

// ishr(5,2) = 5 >> 2 = 1
	bipush 5
	bipush 2
	ishr      // 5 >> 2 = 0b101 >> 2 = 0b001 = 1
	pop

// test edge cases
// ishl(55,99) = 55 >> (99 & 31) = 55 >> 3 = 0b00110111 >> 3 = 0b00000110 = 6
	bipush 55
	bipush 99
	ishr
	ireturn
