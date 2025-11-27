#!/usr/bin/env zsh

#####
# https://sqlite-utils.datasette.io/en/stable/installation.html
# utils to conver tsc/csv into sqlite database
# Install these first
# 1. npm install -g mcp-sqlite-tools
# 2. brew install sqlite-utils

# extension="${filename##*.}"
# filename="${filename%.*}"
# sqlite-utils insert ./database/Scenario-1/pod_accounting-687b789684-lp2pr.db pod_accounting-687b789684-lp2pr ./ITBench-Snapshots/snapshots/sre/v0.1-ca9707b2-8b70-468b-a8f9-9658438f80b1/Scenario-1/metrics/pod_accounting-687b789684-lp2pr.tsv --tsv

### Sample usage ###
# to save all tables in default.db per scenario
#
# ./tsv-to-sqlite.zsh ./database/
#
# ls ./database/**/*.db
# ./database/Scenario-1/default.db
# ./database/Scenario-102/default.db

sqlite_process() {
	dbdir="$1"
	scenario="$2"
	fpath="./$dbdir/$scenario"
	mkdir -p $fpath
	dbname=default.db
	echo $fpath
	for fullpath in ./ITBench-Snapshots/**/$scenario/**/*.tsv; do
		tablename=$(basename $fullpath .tsv)
		fname=$(basename $fullpath)
		echo $fullpath $tablename $fname
		sqlite-utils insert --tsv "${fpath}/${dbname}" $tablename $fullpath
	done
}

if [[ "$#" -eq 1 ]]; then
	for scpath in ./ITBench-Snapshots/**/Scenario-*; do
		scenario=$(basename $scpath)
		sqlite_process $1 $scenario
	done
else
	echo "This function assumes that you have cloned the tsv repo."
	echo "You should run this just one directory level above the cloned tsv repo."
	echo "Syntax: ./tsv-to-sqlite.zsh database_location"
	echo "Sample Usage: ./tsv-to-sqlite.zsh ./database/"
	exit 1
fi
