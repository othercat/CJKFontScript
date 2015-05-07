#!/bin/bash
#   Hiragino Sans Deployment Bootstrapper.
#   Download the latest Hiragino Chinese GUI Font Modifications Package for Yosemite.
#   (Simplified / Traditional Chinese use Hiragino Sans GB / Old Typeface)
#   @(#)  Replace System Fallbacks Font to Hiragino Sans in the project plist.
#   Installer made by Shiki Suen, Enjoy! 
#   Tested by Shiki Suen on May, 06, 2015, GMT+8.
#   Reference: http://shikisuen.github.io/OSXCJKFontPlists/CTPresetFallbackAnalysis.html
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

sudo curl -L $'https://github.com/othercat/CJKFontScript/releases/download/Latest/HiraginoChineseGUIFontForYosemite.pkg.zip' -o ~/Desktop/HiraginoChineseGUIFontForYosemite.pkg.zip
bsdtar -xvf ~/Desktop/HiraginoChineseGUIFontForYosemite.pkg.zip
sudo installer -pkg ~/Desktop/HiraginoChineseGUIFontForYosemite.pkg -target /

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
