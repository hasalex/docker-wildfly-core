FROM sewatech/java8
MAINTAINER Alexis Hassler <alexis@sewatech.org>

ENV WILDFLY_CORE_VERSION 1.0.0.Beta2

RUN apt-get update && apt-get install -y unzip maven2 &&\
    curl -Ls http://central.maven.org/maven2/org/wildfly/core/wildfly-core-build/$WILDFLY_CORE_VERSION/wildfly-core-build-$WILDFLY_CORE_VERSION.zip -o wildfly-core.zip && \
    unzip -q wildfly-core.zip && rm wildfly-core.zip && mv wildfly-core-$WILDFLY_CORE_VERSION wildfly-core &&\
    wildfly-core/bin/add-user.sh --silent admin passw0rd!

# Modules in wildfly-core-build rely on m2 repo. Need to download artefacts
ENV MVN_JBOSS_REPO https://repository.jboss.org/nexus/content/groups/public/
RUN mvn dependency:get -DremoteRepositories=$MVN_JBOSS_REPO -Dartifact=org.wildfly.core:wildfly-server:$WILDFLY_CORE_VERSION &&\
    mvn dependency:get -DremoteRepositories=$MVN_JBOSS_REPO -Dartifact=xerces:xercesImpl:2.11.0.SP3 &&\
    mvn dependency:get -DremoteRepositories=$MVN_JBOSS_REPO -Dartifact=org.slf4j:slf4j-api:1.7.7.jbossorg-1 &&\
    mvn dependency:get -DremoteRepositories=$MVN_JBOSS_REPO -Dartifact=org.jboss.slf4j:slf4j-jboss-logmanager:1.0.3.GA

EXPOSE 9990

ENTRYPOINT ["/wildfly-core/bin/standalone.sh"]
CMD ["-bmanagement", "0.0.0.0"]
