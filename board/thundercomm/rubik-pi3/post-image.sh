#!/bin/bash

echo "QCS6490 Post image script"
PTOOL=${HOST_DIR}/bin/qcom-ptool

${PTOOL} --version
${PTOOL} gen_partition -i ${BINARIES_DIR}/partitions/partitions.conf -o \
    ${BINARIES_DIR}/partitions/partitions.xml
(cd "${BINARIES_DIR}/partitions" && ${PTOOL} ptool -x partitions.xml)
