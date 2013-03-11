#!/bin/sh -e

if [ ! -d bin ] ; then
  mkdir -p bin
fi

dmd -g -unittest -odbin -ofbin/deject deject/*.d deject/detail/*.d
