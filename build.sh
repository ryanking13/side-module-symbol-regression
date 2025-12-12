#!/bin/sh

set -ex

SIDE_MODULE_FLAG=""

for arg in "$@"; do
    case $arg in
        --enable-side-module)
        SIDE_MODULE_FLAG="-sSIDE_MODULE=1"
        shift
        ;;
    esac
done


emcc -c dep.c ${SIDE_MODULE_FLAG} -O0 -I. -o dep.o
emcc -shared -sSIDE_MODULE=1 -O0 -o libdep.so dep.o
emcc -c base.c ${SIDE_MODULE_FLAG} -O0 -fPIC  -I. -o base.o
emcc -shared -fPIC -sSIDE_MODULE=1 -O0 -o libbase.so base.o -L. -ldep '-Wl,-rpath,$ORIGIN'
emcc -o main.js main.c -sMAIN_MODULE=2 --embed-file libbase.so@/libbase.so --embed-file libdep.so@/libdep.so -sNO_AUTOLOAD_DYLIBS

node main.js