#!/bin/bash
#   Hiragino Sans Deployment Script
#   Get OS X's default Chinese GUI font replaced into Hiragino Sans.
#	(Simplified Chinese use Hiragino Sans GB, Traditional Chinese use Hiragino Kaku Pro)
#   @(#)  Repleace System Fallbacks Font to Hiragino Sans in the project plist.
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
# Permission Requirements
#============================================
if [ $(id -u) != 0 ]; then
	echo "Please use SUDO command to execute this BASH script."
	exit
fi

#============================================
# Public Instant Variables
#============================================
cdir=$(cd "$(dirname "$0")"; pwd) #current dir
fdrGarage="${HOME}/.FontInstallerTemporaryWorkingDir"
PlistBuddy="/usr/libexec/PlistBuddy"
Plutil="plutil"
PlistFileRegx="./plistFileRegx"
BackupPath="${HOME}/.FactorialCJKFontSettingsBackup"
SystemFontsPath="/System/Library/Fonts"
WorkingDirectory="/System/Library/Frameworks/CoreText.framework/Versions/A/Resources"

#============================================
# Create Working Directory
#============================================
if [ ! -d ${fdrGarage} ]
then
	echo "Making Working directory ${fdrGarage}."
	mkdir ${fdrGarage}
fi

#============================================
# Download PlistFileRegX
#============================================
cd ${fdrGarage}
if [ ! -f ${PlistFileRegx} ]
then
	curl -L https://github.com/othercat/CJKFontScript/raw/master/plistFileRegx\?raw\=true -o ${PlistFileRegx}
	if [ ! -f ${PlistFileRegx} ]
	then
		echo "Fail to download plistRegEx file."
	exit
fi
else
	echo "PlistFileRegX exists."
fi
chmod +x ${PlistFileRegx}

#=======================================
# Backup phase for plists
#=======================================
if [ ! -d ${BackupPath} ]
then
	echo "Making Backup directory ${BackupPath}."
	mkdir ${BackupPath}
fi

if [ -f ${BackupPath}/CTPresetFallbacks.plist.bak ];
then
   mv ${BackupPath}/CTPresetFallbacks.plist.bak   ${BackupPath}/CTPresetFallbacks.plist.RenamedWhen`date +%Y%m%d_%H%M%S`.bak
fi
cp ${WorkingDirectory}/CTPresetFallbacks.plist   ${BackupPath}/CTPresetFallbacks.plist.bak

if [ -f ${BackupPath}/DefaultFontFallbacks.plist.bak ];
then
   mv ${BackupPath}/DefaultFontFallbacks.plist.bak   ${BackupPath}/DefaultFontFallbacks.plist.RenamedWhen`date +%Y%m%d_%H%M%S`.bak
fi
cp ${WorkingDirectory}/DefaultFontFallbacks.plist   ${BackupPath}/DefaultFontFallbacks.plist.bak

#========================================================================
# Check Existence of Factorial Hiragino Fonts
#========================================================================
if [ ! -f "/Library/Fonts/Hiragino Sans GB W3.otf" ];
then
	echo "[Hiragino Sans GB W3.otf IS MISSING, ABORT MISSION.]"
	exit
fi

if [ ! -f "/Library/Fonts/Hiragino Sans GB W6.otf" ];
then
	echo "[Hiragino Sans GB W7.otf IS MISSING, ABORT MISSION.]"
	exit
fi

if [ ! -f "/Library/Fonts/ヒラギノ角ゴ Pro W3.otf" ];
then
	echo "[Hiragino Sans Pro W3.otf IS MISSING, ABORT MISSION.]"
	exit
fi

if [ ! -f "/Library/Fonts/ヒラギノ角ゴ Pro W6.otf" ];
then
	echo "[Hiragino Sans Pro W6.otf IS MISSING, ABORT MISSION.]"
	exit
fi

#========================================================================
# Copy Hiragino Fonts into Correct Folder with Correct System Permission
#========================================================================
if [ ! -d ${SystemFontsPath}/"Hiragino Sans GB W3.otf" ];
then
	cp -v "/Library/Fonts/Hiragino Sans GB W3.otf" ${SystemFontsPath}/"Hiragino Sans GB W3.otf"
fi

if [ ! -d ${SystemFontsPath}/"Hiragino Sans GB W6.otf" ];
then
	cp -v "/Library/Fonts/Hiragino Sans GB W6.otf" ${SystemFontsPath}/"Hiragino Sans GB W6.otf"
fi

if [ ! -d ${SystemFontsPath}/"ヒラギノ角ゴ Pro W3.otf" ];
then
	cp -v "/Library/Fonts/ヒラギノ角ゴ Pro W3.otf" ${SystemFontsPath}/"ヒラギノ角ゴ Pro W3.otf"
fi

if [ ! -d ${SystemFontsPath}/"ヒラギノ角ゴ Pro W6.otf" ];
then
	cp -v "/Library/Fonts/ヒラギノ角ゴ Pro W6.otf" ${SystemFontsPath}/"ヒラギノ角ゴ Pro W6.otf"
fi

chown root:wheel ${SystemFontsPath}/"Hiragino Sans GB W3.otf"
chown root:wheel ${SystemFontsPath}/"Hiragino Sans GB W6.otf"
chown root:wheel ${SystemFontsPath}/"ヒラギノ角ゴ Pro W3.otf"
chown root:wheel ${SystemFontsPath}/"ヒラギノ角ゴ Pro W6.otf"
chmod 644 ${SystemFontsPath}/"Hiragino Sans GB W3.otf"
chmod 644 ${SystemFontsPath}/"Hiragino Sans GB W6.otf"
chmod 644 ${SystemFontsPath}/"ヒラギノ角ゴ Pro W3.otf"
chmod 644 ${SystemFontsPath}/"ヒラギノ角ゴ Pro W6.otf"

#========================================
# Convert phase: CTPresetFallbacks.plist
#========================================
Plutil -convert xml1 ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleTraditionalChineseFont-Medium" "HiraKakuPro-W6" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont-Medium" "HiraginoSansGB-W6" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleTraditionalChineseFont-Regular" "HiraKakuPro-W3" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont-Regular" "HiraginoSansGB-W3" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleTraditionalChineseFont-Light" "HiraKakuPro-W3" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont-Light" "HiraginoSansGB-W3" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleTraditionalChineseFont-Ultralight" ".AppleJapaneseFont-Thin" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont-Ultralight" ".AppleJapaneseFont-Thin" ${WorkingDirectory}/CTPresetFallbacks.plist
chown root:wheel ${WorkingDirectory}/CTPresetFallbacks.plist
chmod 644 ${WorkingDirectory}/CTPresetFallbacks.plist

#===========================================
# Convert phase: DefaultFontFallbacks.plist
#===========================================
Plutil -convert xml1 ${WorkingDirectory}/DefaultFontFallbacks.plist

${PlistFileRegx} EntireString ".AppleTraditionalChineseFont" "HiraKakuPro-W3" ${WorkingDirectory}/DefaultFontFallbacks.plist
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont" "HiraginoSansGB-W3" ${WorkingDirectory}/DefaultFontFallbacks.plist
${PlistFileRegx} EntireString "STHeitiTC-Light" "HiraKakuPro-W3" ${WorkingDirectory}/DefaultFontFallbacks.plist
${PlistFileRegx} EntireString "STHeitiSC-Light" "HiraginoSansGB-W3" ${WorkingDirectory}/DefaultFontFallbacks.plist
chown root:wheel ${WorkingDirectory}/DefaultFontFallbacks.plist
chmod 644 ${WorkingDirectory}/DefaultFontFallbacks.plist

#===========================================
# Killing Finder
#===========================================
echo -e "====================================\nWe have to kill Finder, clean the font cache and reboot your Mac. \nPlease restart all applications running after this reboot.\n------------------------------------\nPress ENTER(RETURN) key to continue:\c "
read
killall Finder

#=============================================================
# Force Chronosphere SinoType Gothic Fonts into Backup Folder
#=============================================================
mv -fv ${SystemFontsPath}/STHeiti\ Light.ttc ${BackupPath}/STHeiti\ Light.ttc.bak
mv -fv ${SystemFontsPath}/STHeiti\ Medium.ttc ${BackupPath}/STHeiti\ Medium.ttc.bak
mv -fv ${SystemFontsPath}/STHeiti\ Thin.ttc ${BackupPath}/STHeiti\ Thin.ttc.bak
mv -fv ${SystemFontsPath}/STHeiti\ UltraLight.ttc ${BackupPath}/STHeiti\ UltraLight.ttc.bak
mv -fv "/Library/Fonts/华文细黑.ttf" ${BackupPath}/KabunGothic-Light.ttf.bak
mv -fv "/Library/Fonts/华文黑体.ttf" ${BackupPath}/KabunGothic-Medium.ttf.bak

#=============================================================
# Remove Working Directory
#=============================================================
rm -rf ${fdrGarage}/

#=============================================================
# Clean Font Cache and Force Reboot
#=============================================================
atsutil databases -remove
reboot
