#!/bin/bash
echo "Enter Username:"
read user
kinit ${user}

beeline -f create-hortoniabank-tables.ddl
beeline -f hive_partitions.ddl
