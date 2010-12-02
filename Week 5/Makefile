all: cfib.s cfib afib.o afib

cfib.s: cfib.c
	gcc -nostdlib -S -o $@ $<

cfib: cfib.c
	gcc -nostdlib -g -lc -o $@ $<

afib.o: afib.s
	as -g -o $@ $<

afib: afib.o
	gcc -nostartfiles -o $@ $<

test: cfib afib
	./cfib 10
	./afib 10

clean:
	rm -fv cfib.s cfib afib.o afib
