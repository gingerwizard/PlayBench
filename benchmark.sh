#!/bin/bash

set -o noglob
TRIES=5
QUERY_NUM=1

cloud=$1

on_cluster=""
if [ "$cloud" = "true" ] ; then
    on_cluster=" ON CLUSTER 'default'"
    echo "running against cloud cluster"
fi

data_size=$(clickhouse-client --host "${HOST:=localhost}" --user "${USER:=playbench}" --password "${PASSWORD:=}" --secure --query="SELECT sum(total_bytes) FROM system.tables WHERE database IN ('blogs', 'default')")
now=$(date +'%Y-%m-%d')
echo "{\"system\":\"Cloud\",\"date\":\"${now}\",\"machine\":\"720 GB\",\"cluster_size\":3,\"comment\":\"\",\"tags\":[\"Cloud\"],\"data_size\":${data_size}\",result\":[" > temp.json
cat queries.sql | while read query; do
    clickhouse-client --host "${HOST:=localhost}" --user "${USER:=playbench}" --password "${PASSWORD:=}" --secure --format=Null --query="SYSTEM DROP FILESYSTEM CACHE${on_cluster}"
    echo -n "[" >> temp.json
    for i in $(seq 1 $TRIES); do
        RES=$(clickhouse-client --host "${HOST:=localhost}" --user "${USER:=playbench}" --password "${PASSWORD:=}" --secure --time --format=Null --query="$query" 2>&1 > /dev/null ||:)
        [[ "$?" == "0" ]] && echo "${QUERY_NUM}, ${i} - OK" && echo -n "${RES}" >> temp.json || echo "${QUERY_NUM}, ${i} - FAIL" && echo -n "null" >> temp.json
        [[ "$i" != $TRIES ]] && echo -n "," >> temp.json
    done
    echo "]," >> temp.json

    QUERY_NUM=$((QUERY_NUM + 1))
done

sed '$ s/.$//' temp.json > results.json
echo ']}' >> results.json
cat results.json | jq > temp.json

set +o noglob