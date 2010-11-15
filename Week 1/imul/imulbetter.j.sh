#!/bin/sh
ijvm-asm > gen/imul.bc <<J
// Integer multiplication.
  
.method imul
.args   3			// ( int x, int y )
.define x = 1
.define y = 2		    
.locals 3			// int p, sub, mask;
.define p = 3
.define sub = 4
.define mask = 5

	bipush 0
	istore p		// p = 0;
	bipush 1
	istore sub              // sub = 1;
	bipush 1
	istore mask             // mask = 1;

	iload x
	iload y
	isub
	dup
	iflt post_swap
	ifeq post_swap          // if (x > y)
	iload x
	iload y
	istore x
	istore y                //    x ^= y ^= x ^= y; // (swap x and y) 
post_swap:

while:				// while 	
	iload x
	iflt end_while
	iload x
	ifeq end_while		//    ( x > 0 ) {
	iload x
	iload mask
	iand
	ifeq incrsub            //    if (x & mask != 0) {
	goto post_incrsub
incrsub:
	iload sub
	dup
	iadd
	dup
	istore sub              //       sub += sub;
	iload mask
	ior
	istore mask             //       mask |= sub;
	iload y
	dup
	iadd
	istore y                //       y += y;
post_incrsub:                   //    }
	iload x
	iload sub
	isub
	istore x		//    x = x - sub;
	iload p
	iload y
	iadd
	istore p		//    p = p + y;
	goto while		// }
end_while:
	iload  p
	ireturn			// return p;

.method main
.args   1
.define OBJREF = 44
  
	bipush OBJREF
	ldc_w $1
	ldc_w $2
	invokevirtual imul	
	ireturn			// return imul(2,3);
J
ijvm gen/imul.bc
# vim:ts=8:sw=8:sts=8:
