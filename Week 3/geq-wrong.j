.method main            // int main
.args   3               // ( int a, int b )
.define a = 1
.define b = 2
                        // {
if:     iload a         // if (a >= b)
        iload b
        isub

// stack = a - b, ... ; a - b < 0 => a < b

        iflt else
then:   bipush 1        //   return 1;
        goto endif
else:   bipush 0        //   return 0;
endif:  ireturn         // }
// vim:syn=bytecode:
