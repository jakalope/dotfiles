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
    print paths
    return list(itertools.chain.from_iterable(
     itertools.izip([prefix] * len(paths), paths)))


def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in ['.hpp', '.hxx', '.hh', '.h', '.inl', '.impl']


def getRosMessageFlags():
    try:
        import rosmsg
        import rospkg
        rospack = rospkg.RosPack()
        msg_list = rosmsg.list_msgs
        flags = '-I '.join(dir + '/include' for pkg, dir in
                           msg_list.iterate_packages(rospack, '.msg'))
        return flags

    except:
        return []


def FlagsForFile(filename, **kwargs):
    flags = getDefaultFlags() + getSystemIncludeFlags() + \
            getLocalIncludeFlags(filename) + getRosMessageFlags()

    return {
        'flags': flags,
        'do_cache': True
    }
