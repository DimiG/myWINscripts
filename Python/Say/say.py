#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
'''
@author: Copyright 2014 Dmitri G. <dimi615@pisem.net>
'''
# Copyright 2014 Dmitri G. <dimi615@pisem.net>
# To bring the speech capability for your Windows computer
# Install SAPI5Speech (XP and Windows 7 probably have it already)
# Program tested by Windows 7 PC computer
#

import csv
import sys
import time

import win32com.client


def hello():
    print "\n ......................................."
    print " .           Say the WORDS             ."
    print " .                                     ."
    print " .     Created By: Dmitri G. (2014)    ."
    print " .......................................\n"
    print " Speaking...\n"

def gettext():
    strMsg = []
    intTime = []
    f = open('message.csv','r')
    for row in csv.reader(f):
        strMsg.append(str(row[0])) 
        intTime.append(int(row[1]))
    f.close()
    return (strMsg,intTime)

def bye():
    print "\n DONE speaking! Have a GOOD DAY!!! :)"
    print "\n\n BYE...\n"
    time.sleep(2)
    sys.exit(0)

def main():
    voices = {
    'Anna' : 'Microsoft Anna'
    }

# The voice from the voices dictionary (must be installed onto your Windows 7)
    voice = 'Anna'

# The range is 0(low) - 100(loud)
    volume = 100

# The range is -10(slow) - 10(fast)
    rate = -1

# The text to speak is HERE
    voiceMessage, delayTime = gettext()

# Initialize COM components of MS Speech API
# Yeah, COM is Microsoft's Component Object Model
    speak = win32com.client.Dispatch('Sapi.SpVoice')
    
# Assign the voice
    speak.Voice = speak.GetVoices('Name=' + voices[voice]).Item(0)
    speak.Rate = rate
    speak.Volume = volume

# Speak out the text above
    for i in range(len(voiceMessage)):
        print " " + voiceMessage[i] 
        speak.Speak(voiceMessage[i])
        time.sleep(delayTime[i])

if __name__ == '__main__':
    hello()
    main()
    bye()
