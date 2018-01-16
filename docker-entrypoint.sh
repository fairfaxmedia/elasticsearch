#!/bin/bash

gomplate --file /usr/share/elasticsearch/config/elasticsearch.yml.gotpl --out /usr/share/elasticsearch/config/elasticsearch.yml

exec bin/es-docker
