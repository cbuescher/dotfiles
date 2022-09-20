#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'please specify version to install'
    exit 1
fi
if [[ $1 == 7.* || $1 == 8.* ]]; then
    VERSION=$1-darwin-x86_64
else
    VERSION=$1
fi
if [ ! -f elasticsearch-$VERSION.* ]; then
    url=https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$VERSION.tar.gz
    if curl --output /dev/null --silent --head --fail "$url"; then
	curl -O "$url"
    else
	echo "URL does not exist: $url"
    fi
fi
if [ ! -f kibana-$1-darwin-x86_64.tar.gz ]; then
    url=https://artifacts.elastic.co/downloads/kibana/kibana-$1-darwin-x86_64.tar.gz
    if curl --output /dev/null --silent --head --fail "$url"; then
	curl -O "$url"
    else
	echo "URL does not exist: $url"
    fi
fi
echo "Extracting elasticsearch tarball"
tar xfz elasticsearch-$VERSION.tar.gz
echo "Extracting kibana tarball"
tar xfz kibana-$1-darwin-x86_64.tar.gz

# ---- disable some x-pack features 

xpack.graph.enabled: false
xpack.ml.enabled: false
xpack.watcher.enabled: false

# startup to get enrollment token

echo "Starting ES and waiting to get enrollment token"
./elasticsearch-$1/bin/elasticsearch -p elasticsearch-pid &

sleep 40 

ENROLLMENT_TOKEN=$(./elasticsearch-$1/bin/elasticsearch-create-enrollment-token -s kibana --url https://localhost:9200)

echo "Enrollment token: $ENROLLMENT_TOKEN"

echo "Changing elastic user password"

./elasticsearch-$1/bin/elasticsearch-reset-password --username elastic -i << EOF
y
sesam1234
sesam1234
EOF

echo "Starting Kibana with enrollment token"

./kibana-$1/bin/kibana-setup --enrollment-token $ENROLLMENT_TOKEN &

sleep 30

echo "Stopping ES background process"

kill -SIGTERM `cat ./elasticsearch-$1/elasticsearch-pid`



