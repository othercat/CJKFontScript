#!/bin/bash
#   Source Hans Sans Deployment Script,
#   Get OS X's default CJK GUI font replaced into Source Han Sans.
#
#   @(#)  Repleace System Fallbacks Font to SourceHans TC in the project plist.
#   Note: The project plist could be in directory "Resources" or the project root.
#         Personally, I avoid clutter in the project root.
#               
# Enjoy! othercat@gmail.com verified with OSX Yosemite at 10/21/2014
#
# Found here: http://shikisuen.github.io/OSXCJKFontPlists/
# Set the paths to the build and settings Plist

cdir=$(cd "$(dirname "$0")"; pwd) #current dir
PlistBuddy="/usr/libexec/PlistBuddy"
Plutil="plutil"
PlistFileRegx="./plistFileRegx"
BackupPath="${HOME}/.FactorialCJKFontSettingsBackup"
SystemFontsPath="/System/Library/Fonts"
#WorkingDirectory="${cdir}/ori"
WorkingDirectory="/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/"

if [ $(id -u) != 0 ]; then
	echo "Please use sudo to execute the script"
	exit
fi

rm -f ${cdir}/SourceHanSans.ttc

#============================================
# Download PlistFileRegX; added by ShikiSuen
#============================================
cd ${cdir}
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
	echo "Making directory ${BackupPath}."
	mkdir ${BackupPath}
fi

if [ -f ${BackupPath}/CTPresetFallbacks.plist.bak ];
then
   cp ${WorkingDirectory}/CTPresetFallbacks.plist   ${BackupPath}/CTPresetFallbacks.plist.`date +%Y%m%d_%H%M%S`.bak
else
   cp ${WorkingDirectory}/CTPresetFallbacks.plist   ${BackupPath}/CTPresetFallbacks.plist.bak
fi

if [ -f ${BackupPath}/DefaultFontFallbacks.plist.bak ];
then
   cp ${WorkingDirectory}/DefaultFontFallbacks.plist   ${BackupPath}/DefaultFontFallbacks.plist.`date +%Y%m%d_%H%M%S`.bak
else
   cp ${WorkingDirectory}/DefaultFontFallbacks.plist   ${BackupPath}/DefaultFontFallbacks.plist.bak
fi

#=====================================================================
# Source Han Sans Download and Install with Correct System Permission
#=====================================================================

cd ${cdir}
curl -L https://github.com/adobe-fonts/source-han-sans/blob/release/SuperOTC/SourceHanSans.ttc.zip\?raw\=true | bsdtar -xvf-
if [ ! -f ${cdir}/SourceHanSans.ttc ]
then
	echo "Fail to download font file."
	exit
fi
cp ${cdir}/SourceHanSans.ttc ${SystemFontsPath}/
chown root:wheel ${SystemFontsPath}/SourceHanSans.ttc
chmod 644 ${SystemFontsPath}/SourceHanSans.ttc

#========================================
# Convert phase: CTPresetFallbacks.plist
#========================================

Plutil -convert xml1 ${WorkingDirectory}/CTPresetFallbacks.plist

${PlistFileRegx} "-Bold" "Font-Medium" "Font-Bold" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} "-Heavy" "Font-Medium" "Font-Heavy" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} "-Heavy" "Font-Bold" "Font-Heavy" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} "-Light" "Font-Light" "Font-Normal" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} "-Thin" "Font-Thin" "Font-ExtraLight" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} "-Thin" "Font-UltraLight" "Font-ExtraLight" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} "-UltraLight" "Font-Thin" "Font-ExtraLight" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} "-UltraLight" "Font-UltraLight" "Font-ExtraLight" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleTraditionalChineseFont" "SourceHanSansTC" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont" "SourceHanSansSC" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleKoreanFont" "SourceHanSansK" ${WorkingDirectory}/CTPresetFallbacks.plist
${PlistFileRegx} EntireString ".AppleJapaneseFont" "SourceHanSans" ${WorkingDirectory}/CTPresetFallbacks.plist

chown root:wheel ${WorkingDirectory}/CTPresetFallbacks.plist
chmod 644 ${WorkingDirectory}/CTPresetFallbacks.plist

#===========================================
# Convert phase: DefaultFontFallbacks.plist
#===========================================

Plutil -convert xml1 ${WorkingDirectory}/DefaultFontFallbacks.plist

${PlistFileRegx} EntireString ".AppleTraditionalChineseFont" "SourceHanSansTC" ${WorkingDirectory}/DefaultFontFallbacks.plist
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont" "SourceHanSansSC" ${WorkingDirectory}/DefaultFontFallbacks.plist
${PlistFileRegx} EntireString ".AppleKoreanFont" "SourceHanSansK" ${WorkingDirectory}/DefaultFontFallbacks.plist
${PlistFileRegx} EntireString ".AppleJapaneseFont" "SourceHanSans" ${WorkingDirectory}/DefaultFontFallbacks.plist
${PlistFileRegx} EntireString "STHeitiTC-Light" "SourceHanSansTC-Regular" ${WorkingDirectory}/DefaultFontFallbacks.plist
${PlistFileRegx} EntireString "STHeitiSC-Light" "SourceHanSansSC-Regular" ${WorkingDirectory}/DefaultFontFallbacks.plist
${PlistFileRegx} EntireString "AppleSDGothicNeo-Regular" "SourceHanSansK-Regular" ${WorkingDirectory}/DefaultFontFallbacks.plist
${PlistFileRegx} EntireString "HiraKakuProN-W3" "SourceHanSans-Regular" ${WorkingDirectory}/DefaultFontFallbacks.plist

chown root:wheel ${WorkingDirectory}/DefaultFontFallbacks.plist
chmod 644 ${WorkingDirectory}/DefaultFontFallbacks.plist

#=============================================================
# Force Chronosphere SinoType Gothic Fonts into Backup Folder
#=============================================================
killall Finder
mv -fv ${SystemFontsPath}/STHeiti\ Light.ttc ${BackupPath}/
mv -fv ${SystemFontsPath}/STHeiti\ Medium.ttc ${BackupPath}/
mv -fv ${SystemFontsPath}/STHeiti\ Thin.ttc ${BackupPath}/
mv -fv ${SystemFontsPath}/STHeiti\ UltraLight.ttc ${BackupPath}/
mv -fv /Library/Fonts/华文细黑.ttc ${BackupPath}/
mv -fv /Library/Fonts/华文黑体.ttc ${BackupPath}/

#=============================================================
# Clean Font Cache and Force Reboot
#=============================================================
atsutil databases -remove
reboot
