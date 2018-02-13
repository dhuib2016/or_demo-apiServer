#!/bin/sh

#####################################################################
# usage:
# sh start.sh -- start application @dev
# sh start.sh ${env} -- start application @${env}

# examples:
# sh start.sh prod -- use conf/nginx-prod.conf to start OpenResty
# sh start.sh -- use conf/nginx-dev.conf to start OpenResty
#####################################################################

export PATH=$PATH:/home/cuis/OR/bin
export LD_LIBRARY_PATH=/home/cuis/Dep/glibc-build-2.14

if [ -n "$1" ];then
    PROFILE="$1"
else
    PROFILE=dev
fi

if [ ! -f conf/nginx-${PROFILE}.conf ]; then
    echo "invalid profile: "${PROFILE}
    exit 1
fi

if [[ `ls logs -A directory` ]]; then
    baklogs="logs/old_logs/$(date +'%Y%m%d_%H%M%S')"
    mkdir -p ${baklogs}
    mv ./logs/*.* ${baklogs}/
fi

mkdir -p logs & mkdir -p logs/old_logs & mkdir -p tmp

echo "start OR application with profile: "${PROFILE}
openresty -p $(pwd)/ -c conf/nginx-${PROFILE}.conf