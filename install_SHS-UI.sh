#!/bin/bash
#   Source Hans Sans UI Deployment Bootstrapper.
#   Download the latest SHS-UI CJK GUI Font Modification Package for Yosemite.
#   @(#)  Replace System Fallbacks Font to SourceHanSansUI in the project plist.
#   Installer made by Shiki Suen, Enjoy! 
#   Tested by Shiki Suen on May, 07, 2015, GMT+8.
#   Reference: https://github.com/ShikiSuen/SourceHanSansUI
#   Latest Scripts could be found here: https://github.com/othercat/CJKFontScript

#============================================
# Privileges Requirements
#============================================

if [ $(id -u) != 0 ]
then
	echo "[SUDO command needed to execute this BASH script, ABORT MISSION.]"
	exit
fi

#==========================================================
# Download Package and Perform Unattended Installation
#==========================================================

sudo curl -L $'https://github.com/othercat/CJKFontScript/releases/download/Latest/SHSUI-GUIFontForYosemite.pkg.zip' -o ~/Desktop/SHSUI-GUIFontForYosemite.pkg.zip
cd ~/Desktop/
bsdtar -xvf ~/Desktop/SHSUI-GUIFontForYosemite.pkg.zip
sudo installer -pkg ~/Desktop/SHSUI-GUIFontForYosemite.pkg -target /

#===========================================
# Killing Finder
#===========================================

echo "===================================="
echo "We have to reboot your Mac."
echo "Please restart all applications running after this reboot."
echo "------------------------------------"
echo -e "Press ENTER(RETURN) key to continue:\c "
read

reboot
