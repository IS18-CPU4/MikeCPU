#!/bin/bash -e

cd ../compiler/min-caml-master/
make min-caml
./min-caml shootout/$1
cd -
echo -e "terminate:\n b terminate" | cat ../compiler/min-caml-master/shootout/$1.s - > $1_linked.s

cd ../simulator/assembler/
make
cd -

../simulator/assembler/asm $1_linked.s $1.bin

