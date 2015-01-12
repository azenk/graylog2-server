FROM dockerfile/java

ENV GRAYLOG2_VERSION 0.92.3

RUN curl -L "http://packages.graylog2.org/releases/graylog2-server/graylog2-server-${GRAYLOG2_VERSION}.tgz" | tar -zx -C /opt/

WORKDIR /opt/graylog2-server-${GRAYLOG2_VERSION}/

RUN ln -sf /opt/graylog2-server-${GRAYLOG2_VERSION}/ /opt/graylog2-server
RUN cp /opt/graylog2-server/graylog2.conf.example /etc/graylog2.conf

RUN java -Delasticsearch -Des.path.home="/opt" $properties -cp "$GRAYLOG_HOME/*" org.elasticsearch.plugins.PluginManager -install elasticsearch/elasticsearch-cloud-gce/2.3.0
RUN java -Delasticsearch -Des.path.home="/opt" $properties -cp "$GRAYLOG_HOME/*" org.elasticsearch.plugins.PluginManager -install elasticsearch/elasticsearch-cloud-aws/2.3.0

EXPOSE 12900

CMD ["java", "-jar", "/opt/graylog2-server/graylog2-server.jar"]

