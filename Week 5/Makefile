all: cfib.s cfib

cfib.s: cfib.c
	gcc -nostdlib -S -o $@ $<

cfib: cfib.c
	gcc -nostdlib -o $@ $<

test: cfib
	./cfib; echo $$?
