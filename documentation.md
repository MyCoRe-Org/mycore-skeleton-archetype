Erstellen eines Maven Archetypes für Skeleton
=============================================
- im Skeleton-Parent Projekt:
	> mvn archetype:create-from-project

- Platzhalter: rootArtifactId
  
- in /mycore-skeleton-archetype/src/main/resources/archetype-resources die Modul-Unterverzeichnisse umbenennen.
  "skeleton" -> "__rootArtifactId__
 
 - in /mycore-skeleton-archetype/src/main/resources/META-INF/maven/archetype-metadata.xml
    "skeleton" ersetzen:
	- <archetype-descriptor ... name="${rootArtifactId}-parent">
	  <module id="${rootArtifactId}-module" dir="__rootArtifactId__-module" name="${rootArtifactId}-module">
	  <module id="${rootArtifactId}-module" dir="__rootArtifactId__-module" name="${rootArtifactId}-module">
	  <module id="${rootArtifactId}-cli" dir="__rootArtifactId__-cli" name="${rootArtifactId}-cli">
	 
 mdou
