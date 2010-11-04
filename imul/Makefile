all: imul imul.bc imul.trace

clean:
	@(rm -v imul imul.bc imul.trace || true) 2>/dev/null

imul: imul.c
	gcc -o imul imul.c

imul.j: runwith.sh
	@if ! [ -e imul.j ]; then \
		sh runwith.sh 3 3; \
	fi; \
	touch imul.j

imul.bc: imul.j
	ijvm-asm imul.j > imul.bc

imul.trace: imul.bc wc

wc:
	ijvm imul.bc > imul.trace
	@wc imul.trace
