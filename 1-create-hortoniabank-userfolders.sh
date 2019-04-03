#!/bin/bash
echo "Enter cluster name:"
read cluster

kinit -kt /etc/security/keytabs/hdfs.headless.keytab hdfs-${cluster}@SUPPORT.COM
hadoop fs -mkdir /user/erwin
hadoop fs -chown erwin:hdfs /user/erwin
hadoop fs -mkdir /user/joe-analyst
hadoop fs -chown joe-analyst:analyst /user/joe-analyst
hadoop fs -mkdir /user/kate-hr
hadoop fs -chown kate-hr:hr /user/kate-hr
hadoop fs -mkdir /user/ivanna-eu-hr
hadoop fs -chown ivanna-eu-hr:hr /user/ivanna-eu-hr
hadoop fs -mkdir /user/compliance-erwin
hadoop fs -chown compliance-erwin:compliance /user/compliance-erwin
hadoop fs -mkdir /user/hadooperwin
hadoop fs -chown hadooperwin:hdfs /user/hadooperwin


cp -a Data /tmp
bunzip2 /tmp/Data/*.bz2


hdfs dfs -mkdir -p /user/erwin/hortoniabank_data/us_customers
hdfs dfs -mkdir -p /user/erwin/hortoniabank_data/ww_customers
hdfs dfs -mkdir -p /user/erwin/hortoniabank_data/eu_countries
hdfs dfs -mkdir -p /user/erwin/hortoniabank_data/tax_2015
hdfs dfs -mkdir -p /user/erwin/hortoniabank_data/claim_savings
hdfs dfs -mkdir -p /user/erwin/hortoniabank_data/provider_summary

hdfs dfs -put /tmp/Data/us_customers_data.csv /user/erwin/hortoniabank_data/us_customers
hdfs dfs -put /tmp/Data/ww_customers_data.csv /user/erwin/hortoniabank_data/ww_customers
hdfs dfs -put /tmp/Data/eu_countries.csv /user/erwin/hortoniabank_data/eu_countries
hdfs dfs -put /tmp/Data/tax_2015.csv /user/erwin/hortoniabank_data/tax_2015
hdfs dfs -put /tmp/Data/claim_savings.csv /user/erwin/hortoniabank_data/claim_savings
hdfs dfs -put /tmp/Data/claims_provider_summary_data.csv /user/erwin/hortoniabank_data/provider_summary
hdfs dfs -chown -R erwin:hadoop /user/erwin/hortoniabank_data
hdfs dfs -chmod -R g+wX /user/erwin/hortoniabank_data
