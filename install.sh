#!/bin/bash
#   Source Hans TC Replacement Script
#
#   @(#)  Repleace System Fallbacks Font to SourceHans TC in the project plist.
#   Note: The project plist could be in directory "Resources" or the project root.
#         Personally, I avoid clutter in the project root.
#               
# Enjoy! othercat@gmail.com verified with OSX Yosemite at 10/21/2014
#
# Found here: http://shikisuen.github.io/OSXCJKFontPlists/
# Set the paths to the build and settings Plist

cdir=$(cd "$(dirname "$0")"; pwd)
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

#Backup phase

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

cp ${SystemFontsPath}/STHeiti\ Light.ttc ${BackupPath}/
cp ${SystemFontsPath}/STHeiti\ Medium.ttc ${BackupPath}/
cp ${SystemFontsPath}/STHeiti\ Thin.ttc ${BackupPath}/
cp ${SystemFontsPath}/STHeiti\ UltraLight.ttc ${BackupPath}/
cp /Library/Fonts/华文细黑.ttc ${BackupPath}/
cp /Library/Fonts/华文黑体.ttc ${BackupPath}/

#Convert phase
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

Plutil -convert xml1 ${WorkingDirectory}/CTPresetFallbacks.plist
# sed -e 's/Font-Medium/Font-Bold/g' -i .`date +%Y%m%d.bak` ${WorkingDirectory}/CTPresetFallbacks.plist
# sed -e 's/.AppleTraditionalChineseFont/SourceHanSansTC/g' ${WorkingDirectory}/CTPresetFallbacks.plist

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

killall Finder
rm –f ${SystemFontsPath}/STHeiti\ Light.ttc
rm –f ${SystemFontsPath}/STHeiti\ Medium.ttc
rm –f ${SystemFontsPath}/STHeiti\ Thin.ttc
rm –f ${SystemFontsPath}/STHeiti\ UltraLight.ttc
rm –f /Library/Fonts/华文细黑.ttf
rm –f /Library/Fonts/华文黑体.ttf

atsutil databases -remove
reboot
