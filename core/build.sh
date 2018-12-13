#!/bin/bash -e

cd ../compiler/min-caml-master/
make min-caml
cd -
../compiler/min-caml-master/min-caml $1
echo -e "terminate:\n b terminate" | cat $1.s - > $1_linked.s

cd ../simulator/assembler/
make
cd -

../simulator/assembler/asm $1_linked.s $1.bin

