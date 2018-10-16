CC ?= gcc
CXX ?= g++

all: tolowergb tellenc fixuniqc

tolowergb: tolowergb.c
	${CC} -O3 -o tolowergb tolowergb.c

fixuniqc: fixuniqc.c
	${CC} -O3 -o fixuniqc fixuniqc.c

tellenc: tellenc.cpp
	${CXX} -O2 -o tellenc tellenc.cpp

.PHONY: clean
clean:
	rm -rf tolowergb tellenc
