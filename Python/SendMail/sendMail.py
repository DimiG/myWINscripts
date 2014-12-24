#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# This code is example how to send e-mails by Python script
# Tested by Windows 7 PRO
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
# CODE is HERE
# ===============================================================================

import smtplib
import base64
import sys


# The CLASS definition
class MailPusher:
    def __init__(self, l, p, sn):
        # Setting object variables
        self.l = l
        self.p = p
        self.sn = sn

    # The method definition
    def send_me(self, f, t, s, m):
        # Preparing actual message
        message = "From: %s\nTo: %s\nSubject: %s\n\n%s" % (f, ", ".join(t), s, m)

        # Sending E-MAIL
        try:
            server = smtplib.SMTP(self.sn, 587)
            server.ehlo()
            server.starttls()
            server.login(self.l, base64.b64decode(self.p))

            server.sendmail(f, t, message)
            server.quit()
            return True

        except Exception, e:
            print "Something goes WRONG with MAIL server...", str(e)
            return False


if __name__ == '__main__':
    # Server variables setup
    # Name of server
    server_name = "mail.server.com"
    # Login to mail server
    login = "administrator@server.com"
    # Password base64 encoded on next line
    passwd = "abracadabra"

    # Mail variables setup
    # Sender Mail
    frm = "Administrator <administrator@server.com>"
    # Recipient mail
    to = ["Administrator <administrator@server.com>"]
    # Mail Subject
    subj = "The TEST MESSAGE"
    # Message TEXT
    msg_txt = "My LOVELY TEST MESSAGE..."

    # Create Object
    mp = MailPusher(login, passwd, server_name)
    # Call method
    result = mp.send_me(frm, to, subj, msg_txt)

    # result analise
    if result:
        print "Mail sending is complete"
    else:
        print "Oops, something was wrong..."
    
    sys.exit(0)
