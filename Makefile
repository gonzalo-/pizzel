DASM="/usr/local/bin/dasm"
STELLA="/usr/local/bin/stella"

all:
	${DASM} Pizzel.asm -f3 -v0 -oPizzel.bin -lPizzel.lst -sPizzel.sym

run:
	${STELLA} Pizzel.bin

clean:
	rm Pizzel.bin Pizzel.lst Pizzel.sym
