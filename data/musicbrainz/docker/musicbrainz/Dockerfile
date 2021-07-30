FROM um.bmkg/musicbrainz_base:0.1
LABEL maintainer="arthur"
###
# Maastricht University
# Course: Building and Mining Knowledge Graphs
# Individual project assignment
###

# running as root for assignment. Not usable for production!
# to improve: https://medium.com/@mccode/processes-in-containers-should-not-run-as-root-2feae3f0df3b

ARG PROJECT_HOME=/tmp/project

RUN mkdir ${PROJECT_HOME} && cd ${PROJECT_HOME} \
    && git clone https://github.com/lalinsky/mbdata.git \
    && pip3 install -U mbdata/

COPY script/entrypoint.sh ${PROJECT_HOME}/entrypoint.sh
COPY config/mbslave.conf ${PROJECT_HOME}/mbslave.conf
ENV MBSLAVE_CONFIG=${PROJECT_HOME}/mbslave.conf

# Expose the PostgreSQL port
EXPOSE 5432

WORKDIR ${PROJECT_HOME}
 
#ENTRYPOINT ["/usr/bin/dumb-init", "--"]
#CMD ["mbslave", "sync", "-r"]