# programatically_embedded_tomcat__hello_world
Just an introductory experiment for lightweight testing of small simple Java web apps. This was not tested on Windows (for running a bash-script on Windows, use for example "Git for Windows": https://git-scm.com/install/windows).
Example code with some modifictations and updates thanks to https://www.codejava.net/servers/tomcat/how-to-embed-tomcat-server-into-java-web-applications.

## Launching the embedded tomcat with example servlets: ##
In order to launch the embedded tomcat web server (and to load the example servlets) you can use either the exec-maven-plugin or you can execute the bash-script `copy_dependencies_in_local_temp_folder.sh` to run the skinny JAR file directly.

### Run via exec-maven-plugin: ###

	mvn clean
	mvn package
	mvn exec:java

### Run the skinny JAR file directly: ###

	./copy_dependencies_in_local_temp_folder.sh
	/usr/local/jdk-25/bin/java   -cp 'dependencies_cache/*:target/*'   sidlogism.experiments.TomcatLauncher

This is an non-automated quick-n-dirty workaround. Creating an executable fat JAR via the maven-shade-plugin currently runs into problems with unsigned transitive dependencies for this example project.

## Open example servlets in browser ##
See the example servlets in any desired browser via:
* http://localhost:9876/hello
* http://localhost:9876/sum?a=31&b=11
