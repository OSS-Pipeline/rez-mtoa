name = "mtoa"

version = "3.3.0.1.2018"

authors = [
    "Solid Angle",
    "Autodesk"
]

description = \
    """
    MtoA is a plug-in for Autodesk Maya which allows you to use the Arnold renderer directly in Maya.
    """

requires = [
    "cmake-3+",
    "maya-{maya_version}".format(maya_version=str(version.rsplit(".")[-1]))
]

variants = [
    ["platform-linux"]
]

build_system = "cmake"

with scope("config") as config:
    config.build_thread_count = "logical_cores"

uuid = "mtoa-{version}".format(version=str(version))

def commands():
    env.MAYA_MODULE_PATH.prepend("{root}")
    env.MAYA_RENDER_DESC_PATH.prepend("{root}")

    # Helper environment variables.
    env.MTOA_BINARY_PATH.set("{root}/bin")
    env.MTOA_INCLUDE_PATH.set("{root}/include")
    env.MTOA_LIBRARY_PATH.set("{root}/bin:{root}/plug-ins")
