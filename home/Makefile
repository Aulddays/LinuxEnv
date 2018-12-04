CC ?= gcc
CXX ?= g++

all: bin/tolowergb bin/tellenc bin/fixuniqc

bin/tolowergb: bin/tolowergb.c
	${CC} -O3 -o bin/tolowergb bin/tolowergb.c

bin/fixuniqc: bin/fixuniqc.c
	${CC} -O3 -o bin/fixuniqc bin/fixuniqc.c

bin/tellenc: bin/tellenc.cpp
	${CXX} -O2 -o bin/tellenc bin/tellenc.cpp

.PHONY: clean
clean:
	rm -rf bin/tolowergb bin/tellenc bin/fixuniqc
