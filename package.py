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
    "cmake-3",
    "maya-2018"
]

variants = [
    ["platform-linux"]
]

build_system = "cmake"

with scope("config") as config:
    config.build_thread_count = "logical_cores"

#TODO: Use the SHA1 of the archive instead.
uuid = "mtoa-3.3.0.1.2018"

def commands():
    env.MAYA_MODULE_PATH.prepend("{root}")
    env.MAYA_RENDER_DESC_PATH.prepend("{root}")
