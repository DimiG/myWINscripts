#!/usr/bin/env python

# -*- coding: utf-8 -*-
#
#  pingTEST.py
#
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
''' Testing the subprocess in Python '''

import subprocess, time, sys, os

def bye():
    print "\n\n BYE...\n"
    #os.system("pause")
    sys.exit(0)

def main():
    cmdping = "ping -w 7 127.0.0.1"
    p = subprocess.Popen(cmdping, shell=True, stderr=subprocess.PIPE)

    while True:
        out = p.stderr.read(1)
        if out == '' and p.poll() != None:
            break
        if out != '':
            sys.stdout.write(out)
            sys.stdout.flush()

if __name__ == '__main__':
    main()
    bye()
