#!/bin/bash -e

cd ../compiler/min-caml-master/
make min-caml
cd -
../compiler/min-caml-master/min-caml $1
cat ../compiler/min-caml-master/libmincaml.S $1.s | sed -e "s/\t/ /g" > $1_linked.s

cd ../simulator/assembler/
make
cd -

../simulator/assembler/asm $1_linked.s $1.bin

