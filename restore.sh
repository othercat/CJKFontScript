#!/bin/bash
#   Source Hans TC Restore Script
#   Restore those backups made by installer scripts.
#
#   @(#)  Repleace System Fallbacks Font to SourceHans TC in the project plist.
#   Note: The project plist could be in directory "Resources" or the project root.
#         Personally, I avoid clutter in the project root.
#               
# Enjoy! 
# Original Script for SHS was composed by Richard Li, Modified by Shiki Suen
#
# Tested by Shiki Suen on Oct 26, 2014, GMT+8.
#
# Reference: http://shikisuen.github.io/OSXCJKFontPlists/CTPresetFallbackAnalysis.html
# Set the paths to the build and settings Plist

#============================================
# Public Instant Variables
#============================================

# cdir=$(cd "$(dirname "$0")"; pwd) #current dir
fdrGarage="/tmp/FontInstallationScriptWorkingDirectory"
Plutil="plutil"
PlistFileRegx="./plistFileRegx"
BackupPath="${HOME}/.FactorialCJKFontSettingsBackup"
SystemFontsPath="/System/Library/Fonts"
RestoreDirectory="/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/"

#============================================
# Permission Requirements
#============================================

if [ $(id -u) != 0 ]; then
	echo "Please use SUDO command to execute this BASH script."
	exit
fi

#============================================
# Checking Backup Folder's Existence
#============================================

if [ ! -d "${BackupPath}" ]
then
	echo "Error: No backup folder exists!"
	exit
fi

#============================================
# Restore Backup Plists, Exit if any File Missing
#============================================

if [ -f "${BackupPath}/CTPresetFallbacks.plist.bak" ];
then
	cp  "${BackupPath}/CTPresetFallbacks.plist.bak" "${RestoreDirectory}/CTPresetFallbacks.plist"  
	chown root:wheel "${RestoreDirectory}/CTPresetFallbacks.plist"
	chmod 644 "${RestoreDirectory}/CTPresetFallbacks.plist"
else
   echo "Error: No backup CTPresetFallbacks file exists!"
   exit
fi

if [ -f "${BackupPath}/DefaultFontFallbacks.plist.bak" ];
then
	cp  "${BackupPath}/DefaultFontFallbacks.plist.bak" "${RestoreDirectory}/DefaultFontFallbacks.plist"  
	chown root:wheel "${RestoreDirectory}/DefaultFontFallbacks.plist"
	chmod 644 "${RestoreDirectory}/DefaultFontFallbacks.plist"
else
   echo "Error: No backup DefaultFontFallbacks file exists!"
   exit
fi

#============================================
# Restore SinoType Gothic Fonts
#============================================

cp ${BackupPath}/STHeiti\ Light.ttc.bak ${SystemFontsPath}/STHeiti\ Light.ttc
chown root:wheel ${SystemFontsPath}/STHeiti\ Light.ttc
chmod 644 ${SystemFontsPath}/STHeiti\ Light.ttc
cp ${BackupPath}/STHeiti\ Medium.ttc.bak ${SystemFontsPath}/STHeiti\ Medium.ttc
chown root:wheel ${SystemFontsPath}/STHeiti\ Medium.ttc
chmod 644 ${SystemFontsPath}/STHeiti\ Medium.ttc
cp ${BackupPath}/STHeiti\ Thin.ttc.bak ${SystemFontsPath}/STHeiti\ Thin.ttc
chown root:wheel ${SystemFontsPath}/STHeiti\ Thin.ttc
chmod 644 ${SystemFontsPath}/STHeiti\ Thin.ttc
cp ${BackupPath}/STHeiti\ UltraLight.ttc.bak ${SystemFontsPath}/STHeiti\ UltraLight.ttc
chown root:wheel ${SystemFontsPath}/STHeiti\ UltraLight.ttc
chmod 644 ${SystemFontsPath}/STHeiti\ UltraLight.ttc
cp "${BackupPath}/KabunGothic-Light.ttf.bak"  "/Library/Fonts/华文细黑.ttf"
cp "${BackupPath}/KabunGothic-Medium.ttf.bak"  "/Library/Fonts/华文黑体.ttf"

#===========================================
# Killing Finder
#===========================================

echo "===================================="
echo "We have to kill Finder, clean the font cache and reboot your Mac."
echo "Please restart all applications running after this reboot."
echo "------------------------------------"
echo -e "Press ENTER(RETURN) key to continue:\c "
read

killall Finder

#=============================================================
# Clean Font Cache and Force Reboot
#=============================================================

atsutil databases -remove
reboot
