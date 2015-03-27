WildFly Core image
====

From a binary distribution, built independently, because there's no official distribution.

Build from the source :

    git clone git@github.com:wildfly/wildfly-core.git
    cd wildfly-core
    mvn clean install -DskipTests -Prelease

Pick and upload the zip file :

    curl -T `ls -1 dist/target/wildfly-core-*.zip | grep -v src` \
         -u$BT_USER:$BT_KEY -H \
         "X-Bintray-Override: 1" -H "X-Bintray-Publish: 1" \
         https://api.bintray.com/content/$BT_USER/generic/wildfly-core/$version/wildfly-core-$version.zip
