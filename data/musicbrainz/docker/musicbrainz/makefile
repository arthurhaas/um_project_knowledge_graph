#Dockerfile vars

#vars
IMAGENAME=musicbrainz
REPO=um.bmkg
IMAGEVERSION=0.1
IMAGEFULLNAME=${REPO}/${IMAGENAME}:${IMAGEVERSION}
IMAGEFULLNAME_NOVERSION=${REPO}/${IMAGENAME}

.PHONY: help build all

help:
	    @echo "Makefile commands:"
	    @echo "build"
	    @echo "all"
.DEFAULT_GOAL := all
build:
		@docker build -t ${IMAGEFULLNAME_NOVERSION} .
all: help