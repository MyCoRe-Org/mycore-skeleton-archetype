#set($hash = '#')

${hash} ${projectName}

${hash}${hash} Installation Instructions

* clone repository
* run `mvn clean install`
* unzip ${rootArtifactId}-cli to user defined cli directory
* change to cli directory
* run `bin/${rootArtifactId}.sh create configuration directory`
* you now have a config dir `~/.mycore/${rootArtifactId}`
* configure your database connection in `~/.mycore/${rootArtifactId}/resources/META-INF/persistence.xml`
* perhaps you need to download a driver to `~/.mycore/${rootArtifactId}/lib/`
* run cli command `bin/${rootArtifactId}.sh process config/setup-commands.txt to load default data`
* Go to ${rootArtifactId}-webapp
* Install solr with the command: `mvn solr-runner:copyHome`
* Run solr with the command `mvn solr-runner:start` (End with `mvn solr-runner:stop`)
* Run Jetty with the command: `mvn jetty:run` (End with ctrl+c)
* Fast rebuild and Jetty restart `mvn clean install && cd ${rootArtifactId}-module && mvn jetty:run` (End with ctrl+c)