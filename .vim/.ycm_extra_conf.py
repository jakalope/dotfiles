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
    return getIncludePaths('-isystem', [
        '/usr/include',
        '/usr/local/include',
        '/usr/include/eigen3',
        '/opt/ros/indigo/include'
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

    except ImportError:
        return []


def FlagsForFile(filename, **kwargs):
    flags = \
            getDefaultFlags() + \
            getLocalIncludeFlags(filename) + \
            getRosMessageFlags(filename) + \
            getSystemIncludeFlags() + \
            []
    print flags

    return {
        'flags': flags,
        'do_cache': True
    }
