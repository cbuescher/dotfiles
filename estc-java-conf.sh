# Set JAVA_HOME, in addition set RUNTIME_JAVA_HOME and JAVA{x}_HOME used by elasticsearch builds

# export RUNTIME_JAVA_HOME=$(/usr/libexec/java_home -v 15)
for version in $(seq 7 11); do
  if [ $version -lt 9 ]; then
      export JAVA${version}_HOME=$(/usr/libexec/java_home -v 1.${version})
        else
      export JAVA${version}_HOME=$(/usr/libexec/java_home -v ${version})
  fi
done
export JAVA8FIPS_HOME=/Library/Java/JavaVirtualMachines/jdk8fips/Contents/Home
export JAVA12_HOME=/Users/christoph/.sdkman/candidates/java/12.0.2-open
export JAVA13_HOME=/Users/christoph/.sdkman/candidates/java/13.0.2-open
export JAVA14_HOME=/Users/christoph/.sdkman/candidates/java/14.0.2-open
export JAVA15_HOME=/Users/christoph/.sdkman/candidates/java/15.0.1-open
export JAVA16_HOME=/Users/christoph/.sdkman/candidates/java/16.0.1-open
export JAVA17_HOME=/Users/christoph/.sdkman/candidates/java/17.0.4-oracle
export JAVA18_HOME=/Users/christoph/.sdkman/candidates/java/18.0.2-oracle
export JAVA19_HOME=/Users/christoph/.sdkman/candidates/java/19.0.1-oracle
export JAVA20_HOME=/Users/christoph/.sdkman/candidates/java/20.0.1-oracle
export ES_JAVA_HOME=/Users/christoph/.sdkman/candidates/java/18.0.2-oracle
