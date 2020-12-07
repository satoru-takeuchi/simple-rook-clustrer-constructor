#!/bin/bash

export KUBECONFIG=$HOME/admin.conf \
    KUBE_VERSION=v1.19.2

tests/scripts/kubeadm.sh up
tests/scripts/helm.sh up

export TEST_BASE_DIR="$(pwd)" \
    STORAGE_PROVIDER_TESTS=ceph \
    TEST_SCRATCH_DEVICE=/dev/sdb
_output/tests/linux_amd64/integration -test.v -test.timeout 7200s -test.run 'MultiClusterDeploySuite' 2>&1 | tee _output/tests/integrationTests.log
#_output/tests/linux_amd64/integration -test.v -test.timeout 7200s 2>&1 | tee _output/tests/integrationTests.log
