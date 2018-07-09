Projektverzeichnis erstellen
============================
>mkdir C:\Temp\skeleton2018

MyCore Skeleton Maven Archetype installieren
============================================
>cd C:\Temp\skeleton2018
>git clone https://github.com/rsteph-de/mycore-skeleton-archetype.git
> cd mycore-skeleton-archetype 
> mvn clean install
- Check local archetype catalog: ${USER_HOME}/.m2/repository/archetype-catalog.xml


MyCoRe Application Projekt erstellen
=====================================
> mvn archetype:generate -DarchetypeGroupId=org.mycore.skeleton -DarchetypeArtifactId=mycore-skeleton-archetype -DarchetypeVersion=2018.06.0-SNAPSHOT
>> groupId: org.myinstition.apps.skeleton
>> artifactId: skeleton
>> version: 1.0-SNAPSHOT (default)
>> package: org.myinstition.apps.skeleton (default)
>> mcrSolrMainCoreName: skeleton
>> projectName: My New Skeleton App

Anwendung bauen
================
> cd skeleton
> mvn clean install

CLI-Entpacken
=============
> cd ..
> PowerShell Expand-Archive -Path skeleton\skeleton-cli\target\skeleton-cli-1.0-SNAPSHOT.zip -DestinationPath .
> cd skeleton-cli-1.0-SNAPSHOT

Konfigurationsverzeichnis erstellen
===================================
> bin\skeleton.bat create configuration directory

Datenbankinstallation
======================

Datenbanktreiber herunterladen (z.B. H2)
----------------------------------------
> cd C:\Users\mcradmin\AppData\Local\MyCoRe\skeleton
> cd lib
> PowerShell Invoke-WebRequest -Uri http://repo2.maven.org/maven2/com/h2database/h2/1.4.197/h2-1.4.197.jar -OutFile h2-1.4.197.jar

Datenbank konfigurieren (z.B. H2)
----------------------- 
in resources\META-INF\persistence.xml Datenbank konfigurieren
<property name="javax.persistence.jdbc.url" value="jdbc:h2:file:c:\Users\mcradmin\AppData\Local\MyCoRe\skeleton\data\h2\mycore;AUTO_SERVER=TRUE" />

Solr7
=====
Installation nach Anleitung
---------------------------
gem. http://www.mycore.de/documentation/getting_started/solr_7.html
installieren und starten

Solr7 Konfiguration
-------------------
cd c:\workspaces\SOLR\solr-7.3.1
cd server\solr\configsets
git clone https://github.com/MyCoRe-Org/mycore_solr_configset_main.git mycore_main

cd ..\..\...

bin\solr start
bin\solr create -c my_core_name -d mycore_main

Properties prüfen in skeleton-module\src\main\resources\config\skeleton\mycore.properties
oder explizit in ${MYCORE_HOME}\skeleton\mycore.properties setzen
| MCR.Solr.ServerURL=http://localhost:8983/
| MCR.Solr.Core.main.Name=my_core_name
| MCR.Solr.Core.main.ServerURL=%MCR.Solr.ServerURL%

Core Prüfen http://localhost:8983/solr/#/~cores

Anwendung in Tomcat deployen
=============================
Tomcat installieren und starten
-------------------------------
> cd C:\Temp\skeleton2018
> PowerShell Invoke-WebRequest -Uri http://mirror.netcologne.de/apache.org/tomcat/tomcat-8/v8.5.32/bin/apache-tomcat-8.5.32-windows-x64.zip -OutFile apache-tomcat-8.5.32-windows-x64.zip
> PowerShell Expand-Archive -Path apache-tomcat-8.5.32-windows-x64.zip -DestinationPath .
> cd C:\Temp\skeleton2018\apache-tomcat-8.5.32\bin>
> startup.bat

cd..\webapps
copy ..\..\skeleton\skeleton-webapp\target\skeleton-1.0-SNAPSHOT.war skeleton.war

Ausprobieren: http://localhost:8080/skeleton/
später: http://localhost:8080/skeleton/show-objects-with-files

