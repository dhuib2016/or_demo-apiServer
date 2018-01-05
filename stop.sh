#!/bin/sh

#####################################################################
# usage:
# sh stop.sh -- stop application @dev
# sh stop.sh ${env} -- stop application @${env}

# examples:
# sh stop.sh prod -- use conf/nginx-prod.conf to stop OpenResty
# sh stop.sh -- use conf/nginx-dev.conf to stop OpenResty
#####################################################################

export PATH=$PATH:/home/cuis/OR/bin

if [ -n "$1" ];then
    PROFILE="$1"
else
    PROFILE=dev
fi

# todo:check $1 with ${PROFILE}-nginx.pid

echo "stop lor application with profile: "${PROFILE}
openresty -s quit -p `pwd`/ -c conf/nginx-${PROFILE}.conf

baklogs="logs/old_logs/$(date +'%Y%m%d_%H%M%S')"
mkdir -p ${baklogs}
mv ./logs/*.* ${baklogs}/