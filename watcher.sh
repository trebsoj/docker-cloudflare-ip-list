#!/bin/bash

log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") | $1"
}

log "START (Checks every ${CHECK_INTERVAL_SECONDS}s)"

FILE_LAST_DATA_SENT="/tmp/last-data-sent.txt"


getData(){
    local result=''
    local i=0
    for h in $HOSTNAMES; do 
        ips=$(dig +short $h | sort)
        for ip in $ips; do 
            if [[ $i -gt 0 ]]; then
                result+=','
            fi
            result+='{"ip":"'$ip'","comment":"'$h'"}'
            i=$((i+1))
        done
    done
    echo "[${result}]"
}

getLastDataSent() {
    local result=''
    if [ ! -f $FILE_LAST_DATA_SENT ]; then
        result="empty"
    else
        result=$(cat $FILE_LAST_DATA_SENT)
    fi
    echo "${result}"
}

while true
do
    dataNew=$(getData)
    dataOld=$(getLastDataSent)

    if [ "${dataNew}" = "${dataOld}" ]; then
        log "No update required"
    else 
        log "Update list -> ${dataNew}"
        curl -s -X PUT "https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/rules/lists/${LIST_ID}/items" \
        -H "Authorization: Bearer ${TOKEN}" \
        -H "Content-Type:application/json" \
        --data ${dataNew}
    
        echo "${dataNew}" > $FILE_LAST_DATA_SENT
    fi

    sleep ${CHECK_INTERVAL_SECONDS}
done