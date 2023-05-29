#!/usr/bin/env bash

# [Cypher Shell - Operations Manual](https://neo4j.com/docs/operations-manual/current/tools/cypher-shell/)
expect -c "
	set timeout 3
	spawn cypher-shell
	expect \"username:\"
	send \"${NEO4j_USERNAME}\n\"
	expect \"password:\"
	send \"${NEO4j_PASSWORD}\n\"
	interact
"