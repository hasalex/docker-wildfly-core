FROM sewatech/java8
MAINTAINER Alexis Hassler <alexis@sewatech.org>

ENV WILDFLY_CORE_VERSION 1.0.0.Beta1-SNAPSHOT

RUN apt-get update && apt-get install -y unzip &&\
    curl -Ls https://bintray.com/artifact/download/hasalex/generic/wildfly-core-$WILDFLY_CORE_VERSION.zip -o wildfly-core.zip && \
    unzip wildfly-core.zip && rm wildfly-core.zip &&\
    /wildfly-core-$WILDFLY_CORE_VERSION/bin/add-user.sh --silent alexis hassler

EXPOSE 9990

ENTRYPOINT ["/wildfly-core-1.0.0.Beta1-SNAPSHOT/bin/standalone.sh"]
CMD ["-bmanagement", "0.0.0.0"]

