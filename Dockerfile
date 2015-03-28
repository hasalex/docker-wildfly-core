FROM sewatech/java8
MAINTAINER Alexis Hassler <alexis@sewatech.org>

ENV WILDFLY_CORE_VERSION latest
#1.0.0.Beta4-SNAPSHOT

RUN apt-get update && apt-get install -y unzip &&\
#    curl -Ls https://repository.jboss.org/nexus/service/local/repositories/releases/content/org/wildfly/core/wildfly-core-dist/$WILDFLY_CORE_VERSION/wildfly-core-dist-$WILDFLY_CORE_VERSION.zip -o wildfly-core.zip &&\
    curl -Ls https://bintray.com/artifact/download/hasalex/generic/wildfly-core-$WILDFLY_CORE_VERSION.zip -o wildfly-core.zip &&\
    unzip -q wildfly-core.zip && rm wildfly-core.zip && mv wildfly-core-* wildfly-core &&\
    wildfly-core/bin/add-user.sh --silent admin passw0rd!

EXPOSE 9990

ENTRYPOINT ["/wildfly-core/bin/standalone.sh"]
CMD ["-bmanagement", "0.0.0.0"]
