from distutils.core import setup, Extension

setup(
    name='hgwatchman',
    version='0.4.2',
    author='Siddharth Agarwal',
    maintainer='Siddharth Agarwal',
    maintainer_email='sid0@fb.com',
    url='https://bitbucket.org/facebook/hgwatchman',
    description='Watchman integration for Mercurial',
    long_description="""
This extension integrates Watchman with Mercurial for faster status queries.
    """.strip(),
    keywords='hg watchman mercurial inotify file-watching',
    license='Not determined yet',
    packages=['hgwatchman'],
    ext_modules = [
        Extension('hgwatchman.bser', sources = ['hgwatchman/bser.c'])
    ]
)
