#!/usr/bin/env bash

LOCAL_TEMP_DIR='dependencies_cache'
MAVEN_LOCAL_REPO=~/.m2/repository/

function copyJarFromLocalRepo () {
  # parameter semantics:
  # @param currentJarPrefix  file name prefix of the JAR of the currently handled dependency
  # @param currentRepoSubpath   sub path in local maven repo to the JAR of the currently handled dependency
  # @param version   optional: required version of the currently handled dependency
  #                  provided only in case that there might be ambiguities in deriving the newest dependency version from the repository subfolders
  local -r currentJarPrefix=$1
  local -r currentRepoSubpath=$2
  local -r version=$3
  local -r currentJarName="$currentJarPrefix*.jar"
  if [ ! -e $currentJarName ]; then
    local -r currentDependencyDir="$MAVEN_LOCAL_REPO/$currentRepoSubpath"
    newestVersion=$version
    if [ -z $version ]; then
      newestVersion=$(ls -1 $currentDependencyDir | grep -Ee '^[0-9]' | sort -r   | head -n 1)
    fi
    local -r fullJarName="$currentJarPrefix$newestVersion.jar"
    local -r fullJarPath="$currentDependencyDir/$newestVersion/$fullJarName"
    cp -iv  $fullJarPath .
    if [ ! -e $fullJarName ]; then
      echo "ERROR: couldn't find or copy the expected file $fullJarName into the temporary local folder."
    else
      echo "Copied the JAR-file $fullJarName to temporary local folder. Please check whether it has the correct version."
    fi
  else
    echo "The JAR-file $currentJarName already exists. Please check whether it has the correct version."
  fi
}


# check location of local maven repo
if  [ !  -d  "$MAVEN_LOCAL_REPO" ]; then
  echo "Couldn't find the local maven repository at the default location '$MAVEN_LOCAL_REPO'. "
  echo "Please set the script-variable 'MAVEN_LOCAL_REPO' to the path to your configured local maven repository."
  exit -1
fi



# start handling of dependencies (download via "mvn package" + copy to local temporary folder)
echo "This script creates the local temporary folder '$LOCAL_TEMP_DIR' " \
  "and issues 'mvn clean' and 'mvn package' to download the required dependencies (from the Maven central repository) into the local maven repo. " \
  "Afterwards it copies the required JARs of the hardcoded dependencies into the local temporary folder for usage via 'java -cp ...' ."
read -p "Do you wish to proceed? (y/n): "  user_choice
if [[ $user_choice != 'y' ]]; then
  echo "Aborting script."
  exit -1
fi

if  [ !  -d  "./$LOCAL_TEMP_DIR" ]; then
  mkdir $LOCAL_TEMP_DIR
fi




echo "Running 'mvn clean':"
mvn clean
echo "Running 'mvn package':"
mvn package

# copy JARs from local maven repo into local temporary folder
cd $LOCAL_TEMP_DIR
copyJarFromLocalRepo 'jakarta.annotation-api-' 'jakarta/annotation/jakarta.annotation-api'
copyJarFromLocalRepo 'jakarta.servlet-api-' 'jakarta/servlet/jakarta.servlet-api'
copyJarFromLocalRepo 'ecj-' 'org/eclipse/jdt/ecj' '3.46.0'
copyJarFromLocalRepo 'annotations-api-' 'org/apache/tomcat/annotations-api'
copyJarFromLocalRepo 'tomcat-embed-core-' 'org/apache/tomcat/embed/tomcat-embed-core'
copyJarFromLocalRepo 'tomcat-embed-el-' 'org/apache/tomcat/embed/tomcat-embed-el'
copyJarFromLocalRepo 'tomcat-embed-jasper-' 'org/apache/tomcat/embed/tomcat-embed-jasper'
copyJarFromLocalRepo 'tomcat-embed-logging-juli-' 'org/apache/tomcat/embed/tomcat-embed-logging-juli'




