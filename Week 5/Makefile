all: cfib.s cfib afib.o afib

cfib.s: cfib.c
	gcc -nostdlib -S -o $@ $<

cfib: cfib.c
	gcc -nostdlib -g -lc -o $@ $<

afib.o: afib.s
	as -g -o $@ $<

afib: afib.o
	gcc -g -nostartfiles -o $@ $<

test: cfib afib
	./cfib 10
	./afib 10

pdf:
	pdflatex aflevering.tex aflevering.pdf

clean:
	rm -fv cfib.s cfib afib.o afib
