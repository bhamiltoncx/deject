#!/bin/sh -e

dmd -g -unittest deject/*.d deject/detail/*.d
