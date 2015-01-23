FROM dockerfile/java

ENV GRAYLOG2_VERSION 0.92.4

RUN curl -L "http://packages.graylog2.org/releases/graylog2-server/graylog2-server-${GRAYLOG2_VERSION}.tgz" | tar -zx -C /opt/

WORKDIR /opt/graylog2-server-${GRAYLOG2_VERSION}/

RUN ln -sf /opt/graylog2-server-${GRAYLOG2_VERSION}/ /opt/graylog2-server
RUN cp /opt/graylog2-server/graylog2.conf.example /etc/graylog2.conf

COPY graylog2.conf /etc/graylog2.conf
COPY config_manifest /etc/config_manifest
COPY allowed_variables /etc/allowed_variables
COPY config_template_processor.sh /usr/bin/config_template_processor.sh

EXPOSE 12900

ENTRYPOINT ["/usr/bin/config_template_processor.sh"]

CMD ["java", "-jar", "/opt/graylog2-server/graylog2-server.jar"]

