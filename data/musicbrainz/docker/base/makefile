#Dockerfile vars

#vars
IMAGENAME=musicbrainz_base
REPO=um.bmkg
IMAGEVERSION=0.1
IMAGEFULLNAME=${REPO}/${IMAGENAME}:${IMAGEVERSION}

.PHONY: help build all

help:
	    @echo "Makefile commands:"
	    @echo "build"
	    @echo "all"
.DEFAULT_GOAL := all
build:
		@docker build -t ${IMAGEFULLNAME} .
all: help