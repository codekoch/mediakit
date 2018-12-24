# -*- coding: utf-8 -*-
import pymsgbox
import os
import sys
import pymsgbox.native as pymsgbox
modul = pymsgbox.prompt(text='Geben Sie einen Namen für das Modul ein (z.B. 02_PC_Raum102.sb):', title='Modul erstellen', default='02_modulname.sb')
if modul == '02_modulname.sb' :
        os.system('/sbin/saveModul.sh 02_modulname.sb')
else: 
        os.system('/sbin/saveModul.sh %s' % modul)
sys.exit()
