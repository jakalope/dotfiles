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
    # '/usr/bin/../lib/gcc/x86_64-linux-gnu/4.8/../../../../include/c++/4.8',
    # '/usr/bin/../lib/gcc/x86_64-linux-gnu/4.8/include',
    return getIncludePaths('-isystem', [
        '/opt/ros/indigo/include',
        '/usr/include/x86_64-linux-gnu/c++/4.8',
        '/usr/include/c++/4.8/backward',
        '/usr/local/include',
        '/usr/lib/llvm-3.6/bin/../lib/clang/3.6.0/include',
        '/usr/include/x86_64-linux-gnu',
        '/usr/include',
        '/usr/include/eigen3',
    ])


def getBazelWorkspace(current):
    while len(current) > 0:
        current = os.path.dirname(current)
        if os.path.exists(os.path.join(current, 'WORKSPACE')):
            return current
    return None


def getLocalIncludeFlags(filename):
    return getIncludePaths('-I', [
        '.',
        './include',
        getBazelWorkspace(filename),
        os.path.join(getBazelWorkspace(filename), 'bazel-genfiles'),
    ])


def getIncludePaths(prefix, paths):
    paths = filter(lambda path: os.path.exists(path), set(paths))
    return list(itertools.chain.from_iterable(
     itertools.izip([prefix] * len(paths), paths)))


def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in ['.hpp', '.hxx', '.hh', '.h', '.inl', '.impl']


def getRosMessageFlags(filename):
    try:
        import rosmsg
        import rospkg
    except ImportError:
        return []

    try:
        rospack = rospkg.RosPack()
        pkgs = [pkg for pkg, dir in rosmsg.iterate_packages(rospack, '.msg')]
        path = os.path.join(getBazelWorkspace(filename), 'bazel-genfiles')
        paths = []
        for root, dirs, _ in os.walk(path):
            for directory in dirs:
                if directory in pkgs:
                    abs_path = os.path.join(root, directory)
                    paths.append('-I')
                    paths.append(abs_path)
        return paths
    except:
        return []


def FlagsForFile(filename, **kwargs):
    flags = \
            getDefaultFlags() + \
            getLocalIncludeFlags(filename) + \
            getSystemIncludeFlags() + \
            getRosMessageFlags(filename) + \
            []
    print flags

    return {
        'flags': flags,
        'do_cache': True
    }
