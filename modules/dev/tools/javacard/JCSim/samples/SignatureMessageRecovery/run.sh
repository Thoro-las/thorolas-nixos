#!/bin/bash
#
# Copyright (c) 1998, 2025, Oracle and/or its affiliates. All rights reserved.

sample_name=${PWD##*/}
samples_dir=$(dirname ${PWD})

client_name=com.oracle.javacard.sample.AMSSignatureMessageRecoveryClient

cap=${samples_dir}/${sample_name}/applet/deliverables/SignatureMessageRecovery/com/oracle/jcclassic/samples/signaturemessagerecovery/javacard/signaturemessagerecovery.cap
props=${JC_HOME_SIMULATOR}/samples/client.config.properties

client_args="-cap=${cap} -props=${props}"

cd ..
./run.sh ${sample_name} ${client_name} "${client_args}"
result=$?
cd ~-

exit ${result}
