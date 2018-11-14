#!/usr/bin/env bash

source /root/bootstrap/*

gomplate --file /usr/share/elasticsearch/config/elasticsearch.yml.gotpl \
         --datasource settings=file:///usr/share/elasticsearch/config/elasticsearch_custom.yml \
         --out /usr/share/elasticsearch/config/elasticsearch.yml

ulimit -l unlimited

exec /usr/local/bin/docker-entrypoint.sh $@
