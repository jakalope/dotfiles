import gdb
import os


def skip_folder_impl(arg, from_tty):
    for root, dirs, files in os.walk(arg, topdown=False, followlinks=True):
        for name in files:
            path = os.path.join(arg, name)
            gdb.execute(
                'skip file {}'.format(name), from_tty=from_tty, to_string=True)


# Based on:
# https://xaizek.github.io/2016-05-26/skipping-standard-library-in-gdb/
class SkipFolder(gdb.Command):
    'Skip all files under the given directory.'

    def __init__(self):
        super(SkipFolder, self).__init__('skip_folder', gdb.COMMAND_SUPPORT,
                                         gdb.COMPLETE_FILENAME)

    def invoke(self, arg, from_tty):
        skip_folder_impl(arg, from_tty)


SkipFolder()


class SkipStdLib(gdb.Command):
    'Skip all files in known C++ standard library folders.'

    def __init__(self):
        super(SkipStdLib, self).__init__('skip_stdlib', gdb.COMMAND_SUPPORT,
                                         gdb.COMPLETE_FILENAME)

    def invoke(self, arg, from_tty):
        skip_folder_impl('/usr/include/c++', from_tty)
        skip_folder_impl('bazel-driving/external/gcc_4_8', from_tty)
        skip_folder_impl('bazel-driving/external/clang_3_9', from_tty)
        skip_folder_impl('bazel-driving/external/gcc_4_7_arm', from_tty)


SkipStdLib()
