#!/bin/bash
#
# Copyright (c) 1998, 2025, Oracle and/or its affiliates. All rights reserved.

sample_name=${PWD##*/}
package_list="MyShareable ClientApplet ServerApplet"

echo "Sample name: [${sample_name}]"
echo

cd ..
./build.sh ${sample_name} "${package_list}"
cd ~-

