#set($hash = '#')

${hash} ${projectName}

${hash}${hash} Installation instructions

${hash}${hash}${hash} Version control
* deploy the generated project files to your own Git repository

${hash}${hash}${hash} Build
* clone / checkout project from git repository
* run `mvn clean install`

${hash}${hash}${hash} Create / find  the directory with the MyCoRe Commandline interface
* unpack `${rootArtifactId}-cli/target/${rootArtifactId}-cli.tar` into a user defined CLI directory and change into it
* OR: use the generated CLI directory in `${rootArtifactId}/${rootArtifactId}-cli/target/appassembler`
* remember that you can start the CLI with `bin\\${rootArtifactId}.bat` on Windows and `bin/${rootArtifactId}.sh` on MAC/Linux
* remember that you can exit the CLI with the command `exit`


${hash}${hash}${hash} Configure and run Solr server
* Change to `${rootArtifactId}-webapp` directory
* Install and configure solr with the commands: 
  * `mvn solr-runner:copyHome`
  * `mvn solr-runner:installConfigSet@cs_main`
  * `mvn solr-runner:installConfigSet@cs_classification`

* Run solr with the command `mvn solr-runner:start` 
* (Solr is usually running at: http://localhost:8983/solr/#/)
* (To stop it return to this directory an run: `mvn solr-runner:stop`)

${hash}${hash}${hash} Configure the application
* change into CLI directory and run:
  `bin/${rootArtifactId}.sh create configuration directory`
  * The configuration directory is created in: `~/.mycore/${rootArtifactId}`
  * (ignore the CLI output `jakarta.persistence.PersistenceException: No Persistence provider for EntityManager named MyCoRe`,
     because the database will be configured by the next steps)
* configure your database connection in `~/.mycore/${rootArtifactId}/resources/META-INF/persistence.xml`
  * (for first steps you can use the preconfigured H2 database)
  * (if you leave the jdbc url unchanged, it will be updated by the next command, pointing to an H2 database file in your data directory)
  * perhaps you need to download a driver to `~/.mycore/${rootArtifactId}/lib/`
* run cli command `bin/${rootArtifactId}.sh reload mappings in jpa configuration file`
* configure Solr cores in `~/.mycore/${rootArtifactId}/mycore.properties`

```
MCR.Solr.ServerURL=http://localhost:8983/
MCR.Solr.Core.main.Name=${mcrSolrMainCoreName}
MCR.Solr.Core.main.ServerURL=%MCR.Solr.ServerURL%
MCR.Solr.Core.classification.Name=${mcrSolrClassCoreName}
MCR.Solr.Core.classification.ServerURL=%MCR.Solr.ServerURL%
```

${hash}${hash}${hash} Initialize the application
* change into CLI directory (see above)
* load default data by running: `bin/${rootArtifactId}.sh process config/setup-commands.txt`

${hash}${hash}${hash} Run web server
* Change to `${rootArtifactId}-webapp` directory
* Run Jetty with the command: `mvn jetty:run` (end with `ctrl+c`)
* Open your browser with: http://localhost:8080/${rootArtifactId}
* (Fast rebuild and Jetty restart `mvn clean install && cd ${rootArtifactId}-module && mvn jetty:run` (End with ctrl+c))