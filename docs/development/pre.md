---
title: Prerequisites
---

## Required prerequisites

The prerequisites are:

- You must have `kubectl`, `oc`, `jq` and [`yq`](https://github.com/mikefarah/yq) installed.
- You must have `kubectl` and `oc` pointing to an existing OpenShift cluster, that you wish to deploy to. Alternatively, you can configure a local CodeReady Containers VM to deploy to.
- The script `./hack/setup/install-pre-req.sh` will install these prerequisites for you, if they're not already installed.

**Note - Mac OS**

If you're using Mac OS, make sure you are using GNU version of `sed` (`sed --version` -> **GNU sed 4.8**), openssl `openssl version` >= v3.0.2 and bash (`bash --version` >= **GNU bash, version 5.2**), because some of the configuration scripts in this repository depend on them.

You can install correct versions of these tools with:
```bash
brew install openssl@3 gnu-sed bash
```
Then make sure the $PATH is updated to point to those tools' binaries (by updating your .bashrc/.zshrc file):
```bash
export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/bin/bash:${PATH}"
```
After opening a new terminal window you should be using correct versions of these tools by default.

## Bootstrapping a cluster

Any Openshift cluster with a configured default Storage Class can be used for the deployment.
If you don't have a cluster, you can try the methods below for allocating one.

### CodeReady Containers Setup

If you don't already have a test OpenShift cluster available, CodeReady Containers is a popular option. It runs a small OpenShift cluster in a single VM on your local workstation.

1. Create or log in using your free Red Hat account, and [install CodeReady Containers (CRC)](https://console.redhat.com/openshift/create/local).

2. Make sure you have the latest version of CRC: `crc version`

3. Run `./hack/setup/prepare-crc.sh` to configure CodeReady Containers with the recommended minimum memory (16 GiB) and CPUs (6) for App Studio. The script has optional parameters for customizing `memory` and `cpu` allowance. It also supports `force delete` of existing cluster. Run `./hack/setup/prepare-crc.sh --help` to see the options. The script will also enable cluster monitoring and log you in as the cluster administrator.

### Quicklab storage setup for clusters

If you are using Quicklab to provision your development cluster, you will need to setup storage prior to running the bootstrap script.

See [Configuring NFS storage provisioner on Quicklab clusters](../../hack/quicklab/README.html)