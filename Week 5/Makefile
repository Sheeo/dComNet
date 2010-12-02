all: cfib.s cfib afib.o afib

cfib.s: cfib.c
	gcc -nostdlib -S -o $@ $<

cfib: cfib.c
	gcc -nostdlib -g -lc -o $@ $<

afib.o: afib.s
	as --32 -g -o $@ $<

afib: afib.o
	ld -melf_i386 -o $@ $<

test: cfib afib
	./cfib 10
	./afib; echo $$?

clean:
	rm -fv cfib.s cfib afib.o afib
