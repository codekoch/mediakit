# -*- coding: utf-8 -*-
import pymsgbox
import os
import sys
import pymsgbox.native as pymsgbox
ip = pymsgbox.prompt(text='Für welche IP soll das Internet gesperrt werden? (z.B. 1.1.1.12 or all)', title='Internet Sperren', default='all')
if ip == 'all' :
	os.system('/usr/bin/blockInternet.sh all')
else: 
	os.system('/usr/bin/blockInternet.sh %s' % ip)
sys.exit()

