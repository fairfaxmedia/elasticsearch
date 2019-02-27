PROCESSORS=$( cat /proc/cpuinfo  | grep processor | wc -l )

export ES_JAVA_OPTS="-XX:ActiveProcessorCount=${PROCESSORS} ${ES_JAVA_OPTS}"
