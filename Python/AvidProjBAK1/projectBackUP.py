#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
'''
@author: Copyright 2014 Dmitri G. <dimi615@pisem.net>
'''
#  Copyright 2014 Dmitri G. <dimi615@pisem.net>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
#
#

''' My CODE is HERE '''
#===============================================================================
# Function description
#===============================================================================

import datetime
import os
import subprocess
import sys


def hello():
    print "\n ......................................."
    print " .        Avid Projects BackUP         ."
    print " .                                     ."
    print " .    Created By: Dmitri G. (2014)     ."
    print " ......................................."

def bye():
    print "\n Program COMPLETE! Have a GOOD DAY! :)"
#    print u' Программа выполнена, хорошего Вам дня!'
    print "\n\n BYE...\n"
    os.system("pause")
    sys.exit(0)

def jobCopy(cmdstr):
    print "\n\n STARTING BACK UP PROCEDURE...\n"
    p = subprocess.Popen(cmdstr, shell=True, stderr=subprocess.PIPE)
 
    while True:
        out = p.stderr.read(1)
        if out == '' and p.poll() != None:
            break
        if out != '':
            sys.stdout.write(out)
            sys.stdout.flush()

def main():
    now = datetime.datetime.now()

    print
    print " Current day is: %d" % now.day
    if now.day%2==0:
        print " Now is Even Date"
        cmdstring = "robocopy.exe /job:C:\JOBtask\ProjectBackup2.rcj"
        jobCopy(cmdstring)
    else:
        print " Now is Odd Date"
        cmdstring = "robocopy.exe /job:C:\JOBtask\ProjectBackup1.rcj"
        jobCopy(cmdstring)

if __name__ == '__main__':
    hello()
    main()
    bye()
