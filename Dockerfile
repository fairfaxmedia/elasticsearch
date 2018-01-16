FROM docker.elastic.co/elasticsearch/elasticsearch:5.5.0

ENV ES_JAVA_OPTS -Xms256m -Xmx256m

USER root

ENV GOMPLATE_VERSION v1.9.1
RUN curl -o /usr/local/bin/gomplate -L https://github.com/hairyhenderson/gomplate/releases/download/${GOMPLATE_VERSION}/gomplate_linux-amd64 \
    && chmod 755 /usr/local/bin/gomplate

USER elasticsearch

RUN sed -i 's|^\(-Xm.2g\)$|#\ \1|' config/jvm.options

RUN elasticsearch-plugin install --batch repository-s3
RUN elasticsearch-plugin install --batch io.fabric8:elasticsearch-cloud-kubernetes:5.5.0
RUN elasticsearch-plugin install --batch https://distfiles.compuscene.net/elasticsearch/elasticsearch-prometheus-exporter-5.5.0.0.zip

USER root

COPY config/elasticsearch.yml.gotpl /usr/share/elasticsearch/config/

COPY docker-entrypoint.sh .
RUN chown elasticsearch: docker-entrypoint.sh && \
    chmod +x docker-entrypoint.sh

USER elasticsearch

ENTRYPOINT ["/usr/share/elasticsearch/docker-entrypoint.sh"]
CMD ["elasticsearch"]
