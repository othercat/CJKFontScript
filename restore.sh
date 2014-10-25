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
# Tested by Shiki Suen on Oct 25, 2014.
#
# Found here: http://shikisuen.github.io/OSXCJKFontPlists/
# Set the paths to the build and settings Plist

cdir=$(cd "$(dirname "$0")"; pwd)
fdrGarage="${HOME}/.FontInstallerTemporaryWorkingDir"
PlistBuddy="/usr/libexec/PlistBuddy"
Plutil="plutil"
PlistFileRegx="./plistFileRegx"
BackupPath="${HOME}/.FactorialCJKFontSettingsBackup"
SystemFontsPath="/System/Library/Fonts"
#RestoreDirectory="${cdir}/ori"
RestoreDirectory="/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/"

if [ $(id -u) != 0 ]; then
	echo "Please use sudo to execute the script"
	exit
fi

#Restore phase

if [ ! -d ${BackupPath} ]
then
	echo "Error: No backup folder exists!"
	exit
fi

if [ -f ${BackupPath}/CTPresetFallbacks.plist.bak ];
then
	cp  ${BackupPath}/CTPresetFallbacks.plist.bak ${RestoreDirectory}/CTPresetFallbacks.plist  
	chown root:wheel ${RestoreDirectory}/CTPresetFallbacks.plist
	chmod 644 ${RestoreDirectory}/CTPresetFallbacks.plist
else
   echo "Error: No backup CTPresetFallbacks file exists!"
   exit
fi

if [ -f ${BackupPath}/DefaultFontFallbacks.plist.bak ];
then
	cp  ${BackupPath}/DefaultFontFallbacks.plist.bak ${RestoreDirectory}/DefaultFontFallbacks.plist  
	chown root:wheel ${RestoreDirectory}/DefaultFontFallbacks.plist
	chmod 644 ${RestoreDirectory}/DefaultFontFallbacks.plist
else
   echo "Error: No backup DefaultFontFallbacks file exists!"
   exit
fi

cp ${BackupPath}/STHeiti\ Light.ttc ${SystemFontsPath}/STHeiti\ Light.ttc
chown root:wheel ${SystemFontsPath}/STHeiti\ Light.ttc
chmod 644 ${SystemFontsPath}/STHeiti\ Light.ttc
cp ${BackupPath}/STHeiti\ Medium.ttc ${SystemFontsPath}/STHeiti\ Medium.ttc
chown root:wheel ${SystemFontsPath}/STHeiti\ Medium.ttc
chmod 644 ${SystemFontsPath}/STHeiti\ Medium.ttc
cp ${BackupPath}/STHeiti\ Thin.ttc ${SystemFontsPath}/STHeiti\ Thin.ttc
chown root:wheel ${SystemFontsPath}/STHeiti\ Thin.ttc
chmod 644 ${SystemFontsPath}/STHeiti\ Thin.ttc
cp ${BackupPath}/STHeiti\ UltraLight.ttc ${SystemFontsPath}/STHeiti\ UltraLight.ttc
chown root:wheel ${SystemFontsPath}/STHeiti\ UltraLight.ttc
chmod 644 ${SystemFontsPath}/STHeiti\ UltraLight.ttc
cp ${BackupPath}/"华文细黑.ttf"  /Library/Fonts/"华文细黑.ttf"
cp ${BackupPath}/"华文黑体.ttf"  /Library/Fonts/"华文黑体.ttf"

echo -e "====================================\nWe have to kill Finder, clean the font cache and reboot your Mac. \nPlease restart all applications running after this reboot.\n------------------------------------\nPress any key to continue:\c "
read

killall Finder
atsutil databases -remove
reboot
