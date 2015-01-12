FROM dockerfile/java

ENV GRAYLOG2_VERSION 0.92.3

RUN curl -L "http://packages.graylog2.org/releases/graylog2-server/graylog2-server-${GRAYLOG2_VERSION}.tgz" | tar -zx -C /opt/

WORKDIR /opt/graylog2-server-${GRAYLOG2_VERSION}/

RUN ln -sf /opt/graylog2-server-${GRAYLOG2_VERSION}/ /opt/graylog2-server
RUN cp /opt/graylog2-server/graylog2.conf.example /etc/graylog2.conf

COPY graylog2.conf /etc/graylog2.conf

EXPOSE 12900

CMD ["java", "-jar", "/opt/graylog2-server/graylog2-server.jar"]

