#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

EXTRACT_PATH=$1
INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
MTOA_URL=$2
MTOA_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "==============="
echo -e "=== INSTALL ==="
echo -e "==============="
echo -e "\n"

echo -e "[INSTALL][ARGS] EXTRACT PATH: ${EXTRACT_PATH}"
echo -e "[INSTALL][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[INSTALL][ARGS] MTOA URL: ${MTOA_URL}"
echo -e "[INSTALL][ARGS] MTOA VERSION: ${MTOA_VERSION}"

# We created the necessary directories.
MTOA_EXTRACT_PATH=${EXTRACT_PATH}/MtoA
mkdir -p ${MTOA_EXTRACT_PATH}

# We install MtoA.
echo -e "\n"
echo -e "[INSTALL] Installing MtoA-${MTOA_VERSION}..."
echo -e "\n"

# We extract the content of the .run file in a manner that it does not ask for explicit user input.

${MTOA_URL} --noexec --target ${EXTRACT_PATH}
unzip -o ${EXTRACT_PATH}/package.zip -d ${MTOA_EXTRACT_PATH}

# We setup the .mod file to point correctly to our package.
sed "s|+ mtoa any.*|+ mtoa any ${INSTALL_PATH}|1" --in-place ${MTOA_EXTRACT_PATH}/mtoa.mod

# We copy the necessary files to the install directory.
cp -R ${MTOA_EXTRACT_PATH}/* ${INSTALL_PATH}

echo -e "\n"
echo -e "[INSTALL] Finished installing MtoA-${MTOA_VERSION}!"
echo -e "\n"
