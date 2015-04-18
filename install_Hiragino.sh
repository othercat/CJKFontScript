#!/bin/bash
#   Hiragino Sans Deployment Bootstrapper.
#   Download the latest Hiragino Chinese GUI Font Package for Yosemite.
#   (Simplified / Traditional Chinese use Hiragino Sans GB / Old Typeface)
#   @(#)  Replace System Fallbacks Font to Hiragino Sans in the project plist.
#   Installer made by Shiki Suen, Enjoy! 
#   Tested by Shiki Suen on Apr, 18, 2015, MST.
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

sudo curl -L $'https://github.com/othercat/CJKFontScript/raw/master/HiraginoChineseGUIFontForYosemite.pkg' -o ~/Desktop/HiraginoChineseGUIFontForYosemite.pkg
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
