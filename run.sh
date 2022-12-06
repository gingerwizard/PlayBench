#!/bin/bash

set -o noglob
TRIES=3
QUERY_NUM=1
now=$(date +'%Y-%m-%d')
echo "{\"system\":\"Cloud\",\"date\":\"${now}\",\"machine\":\"720 GB\",\"cluster_size\":3,\"comment\":\"\",\"tags\":[\"Cloud\"],\"result\":[" > temp.json
cat queries.sql | while read query; do
    clickhouse-client --host "${HOST:=localhost}" --user "${USER:=playbench}" --password "${PASSWORD:=}" --secure --format=Null --query="SYSTEM DROP FILESYSTEM CACHE"
    echo -n "[" >> temp.json
    for i in $(seq 1 $TRIES); do
        RES=$(clickhouse-client --host "${HOST:=localhost}" --user "${USER:=playbench}" --password "${PASSWORD:=}" --secure --time --format=Null --query="$query" 2>&1 > /dev/null ||:)
        [[ "$?" == "0" ]] && echo "${QUERY_NUM}, ${i} - OK" || echo "${QUERY_NUM}, ${i} - FAIL" && exit 1
        
        echo -n "${RES}" >> temp.json
        [[ "$i" != $TRIES ]] && echo -n "," >> temp.json
    done
    echo "]," >> temp.json

    QUERY_NUM=$((QUERY_NUM + 1))
done

sed '$ s/.$//' temp.json > results.json
echo ']}' >> results.json
cat results.json | jq > temp.json

set +o noglob