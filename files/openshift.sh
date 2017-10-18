#!/usr/bin/env bash


OC_VERSION="v3.6.0"
OC_RELEASE="openshift-origin-client-tools-$OC_VERSION-c4dd4cf-linux-64bit"

if /usr/bin/oc version | grep "oc $OC_VERSION"; then
    echo "OpenShift client $OC_VERSION is already installed. done"
else
    mkdir -p /tmp/oc
    echo downloading https://github.com/openshift/origin/releases/download/$OC_VERSION/$OC_RELEASE.tar.gz    
    wget -q -O /tmp/oc/openshift-client.tar.gz https://github.com/openshift/origin/releases/download/$OC_VERSION/$OC_RELEASE.tar.gz
    tar --strip-components=1 -xzvf /tmp/oc/openshift-client.tar.gz -C /tmp/oc/
    mv /tmp/oc/oc /usr/bin/
    rm -rf /tmp/oc
fi
