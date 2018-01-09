#!/bin/sh

#####################################################################
# usage:
# sh start.sh -- start application @dev
# sh start.sh ${env} -- start application @${env}

# examples:
# sh start.sh prod -- use conf/nginx-prod.conf to start OpenResty
# sh start.sh -- use conf/nginx-dev.conf to start OpenResty
#####################################################################

#LD_PRELOAD=/home/cuis/Dep/glibc-build-2.14/libc.so.6
export PATH=$PATH:/home/cuis/OR/bin
export LD_LIBRARY_PATH=/home/cuis/Dep/glibc-build-2.14

if [ -n "$1" ];then
    PROFILE="$1"
else
    PROFILE=dev
fi

# todo:check $1 with ${PROFILE}-nginx.pid

mkdir -p logs & mkdir -p tmp

echo "start lor application with profile: "${PROFILE}
openresty -p `pwd`/ -c conf/nginx-${PROFILE}.conf