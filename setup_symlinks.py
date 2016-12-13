#!/usr/bin/env python

import os
import datetime

def link_file(home, backup_path, fn):
    home_fn = os.path.join(home, '.' + fn)
    dotfiles_fn = os.path.join(home, 'dotfiles', fn)
    backup_fn = os.path.join(backup_path, '.' + fn)

    if os.path.exists(home_fn):
        if not os.path.islink(home_fn):
            try: os.makedirs(backup_path)
            except OSError: pass
            os.rename(home_fn, backup_fn)
        else:
            os.remove(home_fn)
    try:
        os.symlink(dotfiles_fn, home_fn)
    except OSError as e:
        raise Exception(e.strerror + '\n' + dotfiles_fn + '\n' + home_fn)

def main():
    # Find home-files.
    home = os.path.expanduser("~")
    home_files_path = os.path.join(home, 'dotfiles', 'home-files')
    if not os.path.exists(home_files_path):
        raise Exception('Missing ' + home_files_path)

    # Make backup location.
    backup_folder = datetime.datetime.now().strftime('%Y-%m-%d-%H-%M-%S')
    backup_path = os.path.join(home, 'backup', backup_folder)

    with open(home_files_path, 'r') as home_files:
        for line in home_files:
            link_file(home, backup_path, line.strip())

if __name__ == '__main__':
    main()

