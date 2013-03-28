#!/bin/sh -e

if [ ! -d bin ] ; then
  mkdir -p bin
fi

dmd -g -unittest -odbin -ofbin/deject_test main.d deject/*.d deject/detail/*.d test/*.d
./bin/deject_test
