import itertools
import os


def getDefaultFlags():
    return [
        '-Wall',
        '-Wextra',
        '-Wno-unused-result',
        '-Weffc++',
        '--pipe',
        '-std=c++11',
        '-x', 'c++',
    ]


def getSystemIncludeFlags():
    # '/usr/include/c++/4.8',
    # '/usr/lib/gcc/x86_64-linux-gnu/4.8/include',
    # '/usr/include/x86_64-linux-gnu/c++/4.8',
    # '/usr/include/c++/4.8/backward',
    # '/include/x86_64-linux-gnu',
    return getIncludePaths('-isystem', [
        '/opt/ros/indigo/include',
        '/usr/local/include',
        '/usr/lib/llvm-3.6/lib/clang/3.6.0/include',
        '/usr/include',
        '/usr/include/eigen3',
    ])


def getIncludePaths(prefix, paths):
    paths = filter(lambda path: os.path.exists(path), set(paths))
    return list(itertools.chain.from_iterable(
     itertools.izip([prefix] * len(paths), paths)))


def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in ['.hpp', '.hxx', '.hh', '.h', '.inl', '.impl']


def FlagsForFile(filename, **kwargs):
    flags = \
            getDefaultFlags() + \
            getSystemIncludeFlags() + \
            []
    print flags

    return {
        'flags': flags,
        'do_cache': True
    }
