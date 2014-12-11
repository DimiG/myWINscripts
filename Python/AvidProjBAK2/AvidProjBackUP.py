#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# This program Archive and BackUP Avid projects to Avid server (Disk Z:\)
# For Windows 7 Pro platform
#
# Copyright 2015 Dmitri G. <dimi615@pisem.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.
#
#
#
# CODE is HERE
# ===============================================================================
# Functions description
# ===============================================================================

import os
import sys
import time
import shutil
import zipfile as zf
import tempfile
import winsound

from colorama import init, deinit, Fore, Back


def hello():
    # Colorful output to console
    init(autoreset=True)
    print Fore.CYAN + "\n ......................................."
    print Fore.CYAN + " .        Avid Projects BackUP         ."
    print Fore.CYAN + " .             v1.0 Beta               ."
    print Fore.CYAN + " .     Created By: Dmitri G. (2015)    ."
    print Fore.CYAN + " ......................................."


def wait():
    a = 0
    while a < 17:
        a += 1
        b = (Fore.WHITE + Back.BLUE + " BYE" + "." * a)
        # \r prints a carriage return first, so `b` is printed on top of the previous line.
        sys.stdout.write('\r' + b)
        time.sleep(1)
    # Return terminal color in default position
    print Fore.RESET + Back.RESET


def bye(result):
    if result:
        # IF no ERROR bye message is HERE
        print Fore.YELLOW + "\n Program COMPLETE! Have a GOOD NIGHT! :)"
        print Fore.YELLOW + u' Программа выполнена, хорошего Вам вечера!\n'
        win_beep(True)
    else:
        # IF ERROR bye message is HERE
        print Fore.WHITE + Back.RED + "\a\n There is ERROR! :( Correct IT and RUN program again!                "
        print Fore.WHITE + Back.RED + u' Произошла ОШИБКА! Ликвидируйте причину и повторите запуск программы!\n'
        win_beep(False)

    wait()
    deinit()
    sys.exit(0)


def win_beep(result):
    # BEEP function (specific for Windows ONLY)
    if result:
        # IF no ERROR play beep HERE
        for i in range(3, 7):
            winsound.Beep(i * 100, 200)
    else:
        # IF ERROR play beep HERE
        for i in range(5, 1, -1):
            winsound.Beep(i * 100, 200)


def query_yes_no(question, fn, default="yes"):
    """Ask a yes/no question via raw_input() and return their answer.

    "question" is a string that is presented to the user.
    "default" is the presumed answer if the user just hits <Enter>.
        It must be "yes" (the default), "no" or None (meaning
        an answer is required of the user).

    The "answer" return value is one of "yes" or "no".
    """
    valid = {"yes": "yes", "y": "yes", "ye": "yes", "no": "no", "n": "no"}
    if default is None:
        prompt = " [y/n] "
    elif default == "yes":
        prompt = " [Y/n] "
    elif default == "no":
        prompt = " [y/N] "
    else:
        raise ValueError(" Invalid default answer: '%s'" % default)

    while 1:
        sys.stdout.write(question + fn + '?' + prompt)
        choice = raw_input().lower()
        if default is not None and choice == '':
            return default
        elif choice in valid.keys():
            return valid[choice]
        else:
            sys.stdout.write(" Please respond with 'yes' or 'no' (or 'y' or 'n').\n")


# ===============================================================================
# ZIP functions
# ===============================================================================
def make_zip_ext(zip_arc, dir4zip):
    # Using the external zip.exe utility if needed (NOT USED)
    zip_command = "zip.exe -qr -9 %s %s" % (zip_arc, ''.join(dir4zip))
    # Execute the command
    if os.system(zip_command) == 0:
        print ' Successful created ZIP archive for %s in BacUP directory' % dir4zip
    else:
        print ' BackUP FAILED!'

    return True


def make_zipfile(output_filename, source_dir):
    # Message for user
    print Fore.GREEN + ' Start Avid Project archiving to ZIP...'
    # Use Python module (zipfile) for ZIP
    rel_root = os.path.abspath(os.path.join(source_dir, os.pardir))
    with zf.ZipFile(output_filename, "w", zf.ZIP_DEFLATED) as zippy:
        for root, dirs, files in os.walk(source_dir):
            # add directory (needed for empty dirs)
            zippy.write(root, os.path.relpath(root, rel_root))
            for f in files:
                filename = os.path.join(root, f)
                if os.path.isfile(filename):  # regular files only
                    arc_name = os.path.join(os.path.relpath(root, rel_root), f)
                    try:
                        zippy.write(filename, arc_name)
                    except IOError as e:
                        print Fore.RED + ' Oops! Can\'t create the ZIP file!'
                        print Fore.RED + ' Error: %s' % e.strerror
                        zippy.close()
                        bye(False)

    zippy.close()
    # Message for user
    print Fore.GREEN + ' Successful prepared ZIP archive for %s' % source_dir

    return True


# ===============================================================================
# File manipulation functions
# ===============================================================================
def file_manipulation(fcopylst, bak_dir):
    # Copy ZIP files from temporary directory to BackUP
    for f in fcopylst:
        # Check if file already exist and delete one
        dst_file = os.path.join(bak_dir, os.path.basename(f))
        # Check if destination file already exist
        if os.path.exists(dst_file):
            try:
                os.remove(dst_file)  # remove file
            except Exception, e:
                print Fore.RED + 'Can\'t remove old file in BackUP!', str(e)
                bye(False)
            # Message for user
            print Fore.GREEN + "\n The old file replaced in BackUP!"

        # Message for user
        print Fore.BLUE + '\n ---------------------------------------'
        print Fore.GREEN + " Copy ZIP archive to Avid video server in progress..."

        try:
            shutil.copy(f, bak_dir)
        # eg. source and destination are the same file
        except shutil.Error as e:
            print Fore.RED + ' Error: %s' % e
            bye(False)
        # eg. source or destination doesn't exist
        except IOError as e:
            print Fore.RED + ' Oops! Can\'t copy file to BackUP directory. Check network connection!'
            print Fore.RED + ' Error: %s' % e.strerror
            bye(False)

        # Message for user
        print '\033[37;42;1m' + ' ZIP file copy to Avid video server complete.'


# ===============================================================================
# Directory manipulation functions
# ===============================================================================
def tmp_dir_remove(tmp_dir):
    # Remove temporary directory
    try:
        if os.path.exists(tmp_dir):
            shutil.rmtree(tmp_dir)
    except shutil.Error as e:
        print Fore.RED + ' Error: %s' % e
    except IOError as e:
        print Fore.RED + ' Oops! Can\'t cleanup temporary directory!'
        print Fore.RED + ' Error: %s' % e.strerror


def dir_creator(backup_dir, temp_dir):
    # Create the BackUP directory if it isn't already there
    try:
        if not os.path.exists(backup_dir):
            os.mkdir(backup_dir)  # make directory
            print Fore.GREEN + ' Successfully created BackUP directory', backup_dir
    except OSError:
        print Fore.RED + ' Can\'t create the BackUP directory.\n Check NETWORK CONNECTION for disk Z:'
        bye(False)

    # Create the temporary directory if it isn't already there
    try:
        if not os.path.exists(temp_dir):
            os.mkdir(temp_dir)  # make directory
    except OSError:
        print Fore.RED + ' Can\'t create the temporary directory!'
        bye(False)


# ===============================================================================
# Main code
# ===============================================================================
def main():
    # Get the current date in UNIX format
    now = time.time()

    # Variables setup
    dir_full_path_lst = []
    dir_copy_lst = []
    source = 'C:\\Users\\Public\\Documents\\Shared Avid Projects'
    temp_dir = tempfile.gettempdir() + '\\AvidBackUP\\'
    backup_dir = 'Z:\\BackUP'

    try:
        # Change current dir
        os.chdir(source)
    except OSError:
        print Fore.RED + '\n Can\'t change the Avid project source directory!'
        bye(False)

    for f in os.listdir(source):
        ff = os.path.join(source, f)
        if os.stat(ff).st_mtime > now - 1 * 54000:
            if os.path.isdir(ff):
                dir_copy_lst.append(f)

    # Check if empty job today
    if not dir_copy_lst:
        print Fore.MAGENTA + "\n Nothing to do!"
        bye(True)

    print Fore.MAGENTA + '\n Folders changed today are:'

    for n in dir_copy_lst:
        print '', n
    print Fore.BLUE + ' --------------------------'

    # Creating the BackUP and TEMP dir for script function
    dir_creator(backup_dir, temp_dir)

    for f in dir_copy_lst:
        # print chr(7) # Make a beep in console
        request_answer = query_yes_no(Fore.CYAN + "\a\n Do you wanna BackUP project folder: ", f)
        if request_answer == "no":
            continue
        target = temp_dir + f + '_' + time.strftime('%y%m%d.%H%M') + '.zip'
        dir_full_path_lst.append(target)
        # Execute the ZIP functions HERE
        make_zipfile(target, f)
        # ### make_zip_ext(target, f) ###

    # Invoke File and directory manipulation
    file_manipulation(dir_full_path_lst, backup_dir)
    tmp_dir_remove(temp_dir)


if __name__ == '__main__':
    hello()
    main()
    bye(True)
