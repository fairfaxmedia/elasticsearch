FROM hairyhenderson/gomplate:v3.0.0 as gomplate

FROM docker.elastic.co/elasticsearch/elasticsearch:6.5.1

COPY --from=gomplate --chown=root:root /gomplate /usr/local/bin/gomplate

RUN elasticsearch-plugin install --batch repository-s3
RUN elasticsearch-plugin install --batch https://distfiles.compuscene.net/elasticsearch/elasticsearch-prometheus-exporter-6.5.1.0.zip

RUN sed -i 's|^\(-Xm.1g\)$|#\ \1|' config/jvm.options

RUN { \
      echo '10-:-XshowSettings:vm' ; \
    } >> config/jvm.options

COPY --chown=elasticsearch:root config/elasticsearch.yml.gotpl /usr/share/elasticsearch/config/
COPY --chown=elasticsearch:root docker-entrypoint-wrapper.sh /usr/local/bin
COPY --chown=elasticsearch:root bootstrap /root/bootstrap

ENTRYPOINT ["/usr/local/bin/docker-entrypoint-wrapper.sh"]
CMD ["eswrapper"]
