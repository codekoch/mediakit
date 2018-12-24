# -*- coding: utf-8 -*-
import pymsgbox
import os
import sys
import pymsgbox.native as pymsgbox
pymsgbox.alert(text='Verbindung zu Screencast-Server. \nEmpfohlene Server App: Screen Cast (Deskshare, Inc) für Android. \nAlle Ports des Casting-Gerätes werden freigegeben!', title='Screencast')
ip = pymsgbox.prompt(text='IP des Casting-Gerätes:', title='Screencast Einstellungen', default='1.1.1.2')
port = pymsgbox.prompt(text='Port des Casting-Gerätes auf dem Casting-Service läuft', title='Screencast Settings', default='8888')
#text = "Trying to open the Screencast on %s:%s.\nPress F11 to exit fullscreen.  " % (ip,port)
#pymsgbox.confirm(title='Information',text=text)
os.system('/usr/bin/unblockInternet.sh %s' % (ip))
os.system('google-chrome-stable %s:%s --start-fullscreen &' % (ip,port))
sys.exit()
