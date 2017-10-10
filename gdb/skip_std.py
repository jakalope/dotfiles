import gdb
import os


# Based on:
# https://xaizek.github.io/2016-05-26/skipping-standard-library-in-gdb/
class SkipFolder(gdb.Command):
    'Skip all files under the given directory.'

    def __init__(self):
        super(SkipFolder, self).__init__('skip_folder', gdb.COMMAND_SUPPORT,
                                         gdb.COMPLETE_FILENAME)

    def invoke(self, arg, from_tty):
        for root, dirs, files in os.walk(arg, topdown=False, followlinks=True):
            for name in files:
                path = os.path.join(arg, name)
                gdb.execute(
                    'skip file {}'.format(name),
                    from_tty=from_tty,
                    to_string=True)


SkipFolder()
