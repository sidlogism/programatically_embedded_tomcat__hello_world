# Project programatically_embedded_tomcat__hello_world
This is just an introductory experiment for lightweight testing of small simple Java web apps (to be run via an embedded tomcat web server).
The example code was adopted from [this tutorial](https://www.codejava.net/servers/tomcat/how-to-embed-tomcat-server-into-java-web-applications) by Nam Ha Minh (with some modifictations and updates). Many thanks for that.




## :arrow_forward: Launching the embedded tomcat with example servlets ##
In order to launch the embedded tomcat web server (and to load the example servlets) you can use either the exec-maven-plugin or you can execute the bash-script `copy_dependencies_in_local_temp_folder.sh` in preparation to run the skinny JAR file directly.

### :feather: Run via exec-maven-plugin ###

```bash
mvn clean
mvn package
mvn exec:java
```

### :hotsprings: Run the skinny JAR file directly ###

```bash
./copy_dependencies_in_local_temp_folder.sh
/usr/local/jdk-25/bin/java   -cp 'dependencies_cache/*:target/*'   sidlogism.experiments.TomcatLauncher
```

This is a non-automated quick-n-dirty workaround. Creating an executable fat JAR via the maven-shade-plugin currently runs into problems with unsigned transitive dependencies for this example project.




## :checkered_flag: Open example servlets in browser ##
See the example servlets in any desired browser via:
* http://localhost:9876/hello
* http://localhost:9876/sum?a=31&b=11




## :window: Regarding Microsoft Windows environments ##
The setup was not tested on Windows yet.

For running a bash-script on Windows, use for example [Git for Windows](https://git-scm.com/install/windows).
 :warning: The script `copy_dependencies_in_local_temp_folder.sh` requires the Maven local repository in the default location: `~/.m2/repository/`.
