FROM openjdk:8u131-jdk-alpine
MAINTAINER JS Minet

ENV HBASE_VERSION=1.2.6
ENV APACHE_PHOENIX_VERSION=4.11.0
ENV PATH $PATH:/hbase-${HBASE_VERSION}/bin
	
RUN apk add --no-cache wget tar bash \
	&& wget --progress=bar:force:noscroll -O hbase.tar.gz "http://www-eu.apache.org/dist/hbase/stable/hbase-${HBASE_VERSION}-bin.tar.gz" \
	&& tar xzvf hbase.tar.gz \
	&& rm hbase.tar.gz \
	&& wget --progress=bar:force:noscroll -O apache-phoenix.tar.gz "http://www-eu.apache.org/dist/phoenix/apache-phoenix-${APACHE_PHOENIX_VERSION}-HBase-1.2/bin/apache-phoenix-${APACHE_PHOENIX_VERSION}-HBase-1.2-bin.tar.gz" \
	&& tar xzvf apache-phoenix.tar.gz \
	&& mv /apache-phoenix-${APACHE_PHOENIX_VERSION}-HBase-1.2-bin/phoenix-${APACHE_PHOENIX_VERSION}-HBase-1.2-server.jar /hbase-${HBASE_VERSION}/lib \
	&& rm /apache-phoenix-${APACHE_PHOENIX_VERSION}-HBase-1.2-bin/*.jar \
	&& rm apache-phoenix.tar.gz \
	&& apk del wget tar

COPY hbase-site.xml /hbase-${HBASE_VERSION}/conf

EXPOSE 2181 8080 8085 9090 9095 16000 16010 16201 16301

CMD start-hbase.sh && tail -f /dev/null