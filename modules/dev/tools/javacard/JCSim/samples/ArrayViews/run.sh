#!/bin/bash
#
# Copyright (c) 1998, 2025, Oracle and/or its affiliates. All rights reserved.

sample_name=${PWD##*/}
samples_dir=$(dirname ${PWD})

echo "Sample name: [${sample_name}]"
echo

client_name=com.oracle.javacard.sample.ClientArrayViews

cap_cli=${samples_dir}/${sample_name}/applet/deliverables/ClientApplet/com/oracle/jcclassic/samples/arrayview/ClientApplet/javacard/ClientApplet.cap
cap_srv=${samples_dir}/${sample_name}/applet/deliverables/ServerApplet/com/oracle/jcclassic/samples/arrayview/ServerApplet/javacard/ServerApplet.cap
cap_shr=${samples_dir}/${sample_name}/applet/deliverables/MyShareable/com/oracle/jcclassic/samples/arrayview/MyShareable/javacard/MyShareable.cap
props=${JC_HOME_SIMULATOR}/samples/client.config.properties

client_args="-capClient=${cap_cli} -capServer=${cap_srv} -capShared=${cap_shr} -props=${props}"

cd ..
./run.sh ${sample_name} ${client_name} "${client_args}"
result=$?
cd ~-

exit ${result}
