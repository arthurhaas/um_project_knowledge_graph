FROM ubuntu:latest
LABEL maintainer="arthur"

###
# Maastricht University
# Course: Building and Mining Knowledge Graphs
# Individual project assignment
###

# running as root for assignment. Not usable for production!
# to improve: https://medium.com/@mccode/processes-in-containers-should-not-run-as-root-2feae3f0df3b

ARG DEBIAN_FRONTEND=noninteractive

# https://github.com/lalinsky/mbdata
RUN apt update && \
    apt install -y \
      python3 \
      python3-psycopg2 \
      python3-six \
      python3-certifi \
      python3-setuptools \
      python3-pip \
      postgresql \
      #postgresql-client \
      postgresql-contrib \
      dumb-init \
      git
