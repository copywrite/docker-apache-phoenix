FROM openjdk:8u131-jdk-alpine

MAINTAINER JS Minet

ENV	HBASE_VERSION=1.2.6
ENV PATH $PATH:/hbase-${HBASE_VERSION}/bin
	
RUN apk add --no-cache wget tar \
	&& wget --progress=bar:force:noscroll -O hbase.tar.gz "http://www-eu.apache.org/dist/hbase/stable/hbase-${HBASE_VERSION}-bin.tar.gz" \
	&& tar xzvf hbase.tar.gz \
	&& rm hbase.tar.gz \
	&& apk del wget tar

COPY hbase-site.xml /hbase-${HBASE_VERSION}/conf

EXPOSE 2181 8080 8085 9090 9095 16000 16010 16201 16301

CMD ["start-hbase.sh"]