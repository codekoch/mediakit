#!/bin/bash
zenity --info --text="Opening browser..." --timeout=4 2> /dev/null  &
chromium-browser www.google.de --start-maximized &
