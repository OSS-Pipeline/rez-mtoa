CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

include(RezBuild)
include(RezRepository)

# We split the MtoA version string in multiple ones.
string(REPLACE "." ";" MTOA_VERSION_LIST ${REZ_BUILD_PROJECT_VERSION})
list(GET MTOA_VERSION_LIST 0 MTOA_MAJOR_VERSION)
list(GET MTOA_VERSION_LIST 1 MTOA_MINOR_VERSION)
list(GET MTOA_VERSION_LIST 2 MTOA_PATCH_VERSION)
list(GET MTOA_VERSION_LIST 3 MTOA_HOTFIX_VERSION)
list(GET MTOA_VERSION_LIST 4 MTOA_MAYA_VERSION)

# We create Mayaless version of MtoA to make it match with the one in the archive name.
set(MTOA_MAYALESS_VERSION "${MTOA_MAJOR_VERSION}.${MTOA_MINOR_VERSION}.${MTOA_PATCH_VERSION}.${MTOA_HOTFIX_VERSION}")

# MtoA
rez_set_archive(
    # This is a relative path from the ${REZ_REPO_PAYLOAD_DIR} environment variable,
    # that is pointing to the root directory where we can find all the archives of the package
    # we can build, using the following hierarchy:
    # "${REZ_REPO_PAYLOAD_DIR}/project_name/archive.what.ever"
    MTOA_URL mtoa/MtoA-${MTOA_MAYALESS_VERSION}-linux-${MTOA_MAYA_VERSION}.run
    https://www.arnoldrenderer.com/arnold/download/product-download/?id=2976
)

# The environment variable REZ_TMP_PATH is meant to point to a location such as "/tmp/rez".
set(EXTRACT_DIR $ENV{REZ_TMP_PATH}/mtoa/${REZ_BUILD_PROJECT_VERSION})

# We will only use a Bash script to deal with the installation as it is provided as a .run file,
# which does not play well with the ExternalProject_Add CMake macro.
execute_process(
    COMMAND
    bash ${CMAKE_SOURCE_DIR}/install.sh ${EXTRACT_DIR} ${MTOA_URL}
)

# We use a bogus CMake "install" step in order to be able to properly finish
# and get out of the CMake script.
install(
    CODE
    "execute_process(
        COMMAND echo \"\n[CMAKE] MtoA-${REZ_BUILD_PROJECT_VERSION} PACKAGE SETUP FINISHED!\n\"
    )"
)
