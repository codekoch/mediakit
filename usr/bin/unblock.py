# -*- coding: utf-8 -*-
import pymsgbox
import os
import sys
import pymsgbox.native as pymsgbox
ip = pymsgbox.prompt(text='Für welche IP soll das Internet freigegeben werden? (z.B. 1.1.1.12 or all)',default='all',title='Internet freigeben')
if ip == 'all' :
        os.system('/usr/bin/unblockInternet.sh all')
else: 
        os.system('/usr/bin/unblockInternet.sh %s' % ip)
sys.exit()

