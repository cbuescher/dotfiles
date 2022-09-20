#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'please specify version to install'
    exit 1
fi
if [ ! -f kibana-$1-SNAPSHOT.* ]; then
    url=https://snapshots.elastic.co/downloads/kibana/kibana-$1-SNAPSHOT-darwin-x86_64.tar.gz
    if curl --output /dev/null --silent --head --fail "$url"; then
	curl -O "$url"
    else
	echo "URL does not exist: $url"
    fi
fi
echo "Extracting kibana tarball"
tar xfz kibana-$1-darwin-x86_64.tar.gz
