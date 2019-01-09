# Elasticsearch

## Overview

An opinionated Docker implementation for Elasticsearch focused on providing a reliable yet flexible solution based on the upstream official image.

## Features

There are a number of features that differentiate this implementation from the official or other solutions.

* Configuration determined at runtime by a powerful templating engine.
* AWS availability zone awareness auto detection.
* Extra configuration snippets easy to add.
* Heap sized based on container memory and percentages.
* Enables AWS S3 plugin for snapshots.
* Enables Prometheus plugin for metrics.

## Getting Started

This implementation is designed to be used with a Helm chart. However, there is a docker compose file included for testing this implementation locally. Bringing up a test cluster and discovering the client endpoint is easily done with just 2 commands.

```
docker-compose up
```

It will likely take a few minutes for the containers to start and you can verify when it is available using `curl`.

```
curl $(docker-compose port client 9200)
```

### Prerequisites

The only requirements for bringing up this implementation locally is Docker.

```
Docker 17.12.0+
```

However, be aware that Elasticsearch has significant memory requirements especially since it is Java based and it is necessary to allocate the heap on start to prevent memory fragmentation. With 4 Elasticsearch containers (Discovery, Master, Data and Client), Kibana and Cerebro at least 4388Mi of RAM is required in heap allocation, preferably 6Gi if there is capacity.

### Installing

It is expected that the Helm chart will be used to install this container. For local development, there are a number of ways to interact with Elasticsearch.

The client endpoint is the main way applications interact with Elasticsearch.

```
docker-compose port client 9200
```

Management of Elasticsearch is available using Kibana.

```
docker-compose port kibana 5601
```

An alternative management interface is available using Cerebro.

```
docker-compose port cerebro 9000
```

## Memory Allocation

Running a JVM in a container requires an understand of the relationship of the cgroups memory limit and the heap size. There is an overhead required in running a JVM as well which is approximate 348Mi.

A simple formula to use to determine the RAM percentage is as follows:

```
(Memory limit - 384Mi / Memory limit) * 100
```

## Deployment

For use on live systems, see the documentation for the Helm chart.

## Components

* [Elasticsearch](https://github.com/elastic/elasticsearch) - Open Source, Distributed, RESTful Search Engine
* [Elasticsearch-Docker](https://github.com/elastic/elasticsearch-docker/tree/6.5) - Official Elasticsearch Docker image from Elastic.
* [Gomplate](https://github.com/hairyhenderson/gomplate) - A flexible commandline tool for template rendering. Supports lots of local and remote datasources.
* [Kibana](https://github.com/elastic/kibana) - Kibana analytics and search dashboard for Elasticsearch
* [Cerebro](https://github.com/lmenezes/cerebro) - Cerebro is an open source Elasticsearch web admin tool built using Scala, Play Framework, AngularJS and Bootstrap
* [Prometheus Exporter Plugin for Elasticsearch](https://github.com/vvanholl/elasticsearch-prometheus-exporter) - Prometheus exporter plugin for Elasticsearch

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/fairfaxmedia/elasticsearch/tags).

## Authors

* **Michael Lorant** - *Initial work* - [Nine](https://github.com/mikelorant)

See also the list of [contributors](https://github.com/mikelorant/elasticsearch/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Elastic
* Nine
