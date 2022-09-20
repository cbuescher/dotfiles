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

# -------- install x-pack

if [[ $VERSION == 6.* ]]; then
  echo "installing x-pack"
  elasticsearch-$1/bin/elasticsearch-plugin install -b x-pack
  kibana-$1-darwin-x86_64/bin/kibana-plugin install x-pack
fi

# ------- setup bootstrap password

printf "ses4me" | elasticsearch-$1/bin/elasticsearch-keystore add -f -x "bootstrap.password"

# -------- disable x-pack feature by default


cat >> elasticsearch-$1/config/elasticsearch.yml <<END

# ---- disable some x-pack features 

xpack.graph.enabled: false
xpack.security.enabled: true
xpack.ml.enabled: false
xpack.watcher.enabled: false

# ---- set repo path

path.repo: ["/opt/es_snapshot_repo"]
END

# -------- add elastic user / bootstrap pw to kibana

if [[ $1 == 7.* ]]; then
    KCONF=kibana-$VERSION/config/kibana.yml
else
    KCONF=kibana-$1/config/kibana.yml
fi

cat >> $KCONF <<END
# ---- add elastic user / bootstrap pw

elasticsearch.username: "elastic"
elasticsearch.password: "ses4me"
END

# -------- import example data
#elasticsearch-$VERSION/bin/elasticsearch -p es.pid -d

#echo "Starting elasticsearch to import snapshot repos"
#while ! nc -z localhost 9200; do      sleep 1; done
#echo "Started elasticsearch, pid: `cat es.pid`"

#curl -XGET 'http://localhost:9200/_cluster/health?wait_for_status=yellow&timeout=10s&pretty'

#curl -XPUT "http://localhost:9200/_snapshot/es_snapshot_repo" -H 'Content-Type:application/json' -d'
#{
#  "type": "fs",
#  "settings": {
#    "location": "/opt/es_snapshot_repo",
#        "compress": true
#  }
#}'

#curl -XPOST "http://localhost:9200/_snapshot/es_snapshot_repo/logstash-example/_restore"

#kill -SIGTERM `cat es.pid`
