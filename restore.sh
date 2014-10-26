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
# Tested by Shiki Suen on Oct 26, 2014, MST.
#
# Reference: http://shikisuen.github.io/OSXCJKFontPlists/CTPresetFallbackAnalysis.html
#
# Latest Scripts could be found here: https://github.com/othercat/CJKFontScript

#============================================
# Public Instant Variables
#============================================

fdrGarage="/tmp/FontInstallationScriptSysPlistsDir"
BackupPath="${HOME}/.FactorialCJKFontSettingsBackup"
SystemFontsPath="/System/Library/Fonts"
SysPlistsDir="/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/"
Plutil="plutil"
PlistFileRegx="${fdrGarage}/plistFileRegx"
plisttoolhash="f4f6b442d93cda35a1aec25121318482"

#============================================
# Permission Requirements
#============================================

if [ $(id -u) != 0 ]; then
	echo "[SUDO command needed to execute this BASH script, ABORT MISSION.]"
	exit
fi

#============================================
# Checking Backup Folder's Existence
#============================================

if [ ! -d "${BackupPath}" ]
then
	echo "[NO Backup Folder EXISTS, ABORT MISSION.]"
	exit
fi

#============================================
# Restore Backup Plists, Exit if any File Missing
#============================================

if [ -f "${BackupPath}/CTPresetFallbacks.plist.bak" ];
then
	cp  "${BackupPath}/CTPresetFallbacks.plist.bak" "${SysPlistsDir}/CTPresetFallbacks.plist"  
	chown root:wheel "${SysPlistsDir}/CTPresetFallbacks.plist"
	chmod 644 "${SysPlistsDir}/CTPresetFallbacks.plist"
else
   echo "[CTPresetFallbacks Backup is MISSING, ABORT MISSION.]"
   exit
fi

if [ -f "${BackupPath}/DefaultFontFallbacks.plist.bak" ];
then
	cp  "${BackupPath}/DefaultFontFallbacks.plist.bak" "${SysPlistsDir}/DefaultFontFallbacks.plist"  
	chown root:wheel "${SysPlistsDir}/DefaultFontFallbacks.plist"
	chmod 644 "${SysPlistsDir}/DefaultFontFallbacks.plist"
else
   echo "[DefaultFontFallbacks.plist.bak is MISSING, ABORT MISSION.]"
   exit
fi

#============================================
# Restore SinoType Gothic Fonts
#============================================

cp "${BackupPath}/STHeiti Light.ttc.bak" "${SystemFontsPath}/STHeiti Light.ttc"
chown root:wheel "${SystemFontsPath}/STHeiti Light.ttc"
chmod 644 "${SystemFontsPath}/STHeiti Light.ttc"
cp "${BackupPath}/STHeiti Medium.ttc.bak" "${SystemFontsPath}/STHeiti Medium.ttc"
chown root:wheel "${SystemFontsPath}/STHeiti Medium.ttc"
chmod 644 "${SystemFontsPath}/STHeiti Medium.ttc"
cp "${BackupPath}/STHeiti Thin.ttc.bak" "${SystemFontsPath}/STHeiti Thin.ttc"
chown root:wheel "${SystemFontsPath}/STHeiti Thin.ttc"
chmod 644 "${SystemFontsPath}/STHeiti Thin.ttc"
cp "${BackupPath}/STHeiti UltraLight.ttc.bak" "${SystemFontsPath}/STHeiti UltraLight.ttc"
chown root:wheel "${SystemFontsPath}/STHeiti UltraLight.ttc"
chmod 644 "${SystemFontsPath}/STHeiti UltraLight.ttc"
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
