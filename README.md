# PlayBench: a Benchmark For play.clickhouse.com

Based on [ClickBench](https://github.com/ClickHouse/ClickBench/#results-usage-and-scoreboards). We stand on the shoulders of giants.

## Overview

This benchmark aims to measure the performance of variants of play.clickhouse.com. Queries are based on historical usage of the public environment.

## Goals

To assess the impact of moving play.clickhouse.com from a self-managed environment to ClickHouse Cloud.

We aim to identify where user experience will be better/worse and the types of queries most impacted.

## Assumptions

Performance can be dramatically different based on specific user quotas and settings. We assume `play` user settings without limitations on query throughput. We only test queries which execute successfully based on the quotas and limits applied to the `play` user. This user `playbench` is created on all clusters - [role]() and [user definition]().

We only execute queries which target the `default` or `blogs` databases.

Queries are executed from a machine in the same aws region as the cluster to minimize latency. We rely on `SYSTEM DROP FILESYSTEM CACHE` to clear the FS cache between executions.

## Limitations 

The limitations of this benchmark allow keeping it easy to reproduce and to include more systems in the comparison. The benchmark represents only a subset of all possible workloads and scenarios - specifically it only tests historical queries of the play environment.

## Rules and Contribution

### How To Add a New Result

To add a self-managed or play Cloud environment, simply run `benchmark.sh`.

This script will generate a `results.json` file. Modify the contents of this including:

- `system` - set to either "Self-Managed" or "Cloud"
- `machine` - amount of RAM e.g. `720 GB` - total of all nodes.
- `cluster_size` - number of nodes
- `comment` misc e.g. any fining tuning performed.

Other fields should be automatically completed.

Rename `results.json` to `<cloud|self-managed>-<total_mem_size>.json` and copy to `./results` e.g. `cloud-720.json`.

The systems can be installed or used in any reasonable way: from a binary distribution, from a Docker container, from the package manager, or compiled - whatever is more natural and simple or gives better results.

It's better to use the default settings and avoid fine-tuning. Configuration changes can be applied if it is considered strictly necessary and documented.

Fine-tuning and optimization for the benchmark are not recommended but allowed. In this case, add the results on vanilla configuration and fine-tuned configuration separately

### Data Loading

The target instance should have a copy of all play.clickhouse.com data - specifically the `default` and `blogs` databases. 
See github.com/clickhouse/play.clickhouse.com

### Results Usage And Scoreboards

See [ClickBench](https://github.com/ClickHouse/ClickBench/#results-usage-and-scoreboards)

### Useful scripts

#### Find all queries in docs with play queries:

```bash
cd clickhouse-docs
grep -r "play.clickhouse.com" . | sed -nr "s/.*play\.clickhouse\.com\/play.*#(\S*)\s?/\1/p" |  sed "s/)//g" | awk '{print $1}' > b64_queries.txt
while IFS= read -r line; do echo "$line" | base64 --decode | tr '\n' ' ' | tr -s ' '; echo ""; done < b64_queries.txt > queries.txt
```

####  Find queries in current instance:

```bash
~/clickhouse client --host 52.59.38.70 --password <password> --secure --user migrate --query "SELECT any(query) || '\n--------------------------' FROM system.query_log WHERE query_kind='Select' AND hasAny(databases, ['blogs', 'default', 'git_clickhouse']) AND read_rows > 0 AND user != 'default' GROUP BY normalized_query_hash FORMAT TabSeparatedRaw" | awk 'NF' | awk '{$1=$1;print}'  | tr '\n' ' ' | sed 's/-------------------------- /\n/g' | sed '/^[-\/#]/d' | sed 's/[Ss]elect /SELECT /g' | sed 's/ from / FROM /g' | sed 's/ group / GROUP /g' | sed 's/ where / WHERE /g' | sed 's/ [lL]imit / LIMIT /g' | sed 's/ [Or]der [By]y / ORDER BY /g' | sed 's/^[wW]ith /WITH /g' |  sed 's/;//g' | sort | uniq -i -u > queries.sql
```

#### Validate queries

Assumes `queries.sql`. Checks queries execute with `benchmark/play` user. Outputs valid queries to `valid.sql`.

```bash
export USER=<user>
export PASSWORD=<password>
export HOST=<host>
./validate.sh
```
