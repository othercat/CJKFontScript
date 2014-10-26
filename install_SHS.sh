#!/bin/bash
#   Source Hans Sans Deployment Script,
#   Get OS X's default CJK GUI font replaced into Source Han Sans.
#
#   @(#)  Repleace System Fallbacks Font to Source Han Sans in the project plist.
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
plisttoolhash="f4f6b442d93cda35a1aec25121318482"
BackupPath="${HOME}/.FactorialCJKFontSettingsBackup"
SystemFontsPath="/System/Library/Fonts"
WorkingDirectory="/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/"

#============================================
# Permission Requirements
#============================================

if [ $(id -u) != 0 ]; then
	echo "Please use SUDO command to execute this BASH script."
	exit
fi

#============================================
# Create Working Directory
#============================================

if [ ! -d "${fdrGarage}" ]
then
	echo "Making Working directory ${fdrGarage}."
	mkdir "${fdrGarage}"
fi

#============================================
# Download PlistFileRegX
#============================================

cd "${fdrGarage}"

if [ -f ${PlistFileRegx} ] && [[ ! $(md5 -q ${PlistFileRegx}) = ${plisttoolhash} ]]
then
    echo "MD5 Hash for local plistFileRegx does not match"
	rm -f ${PlistFileRegx}
fi

if [ ! -f ${PlistFileRegx} ]
then
	curl -L https://github.com/othercat/CJKFontScript/raw/master/plistFileRegx\?raw\=true -o ${PlistFileRegx}
	if [ ! -f ${PlistFileRegx} ]
	then
		echo "Fail to download plistRegEx file."
	exit
	fi
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

#=====================================================================
# Source Han Sans Download and Install with Correct System Permission
#=====================================================================

cd "${fdrGarage}"
rm -f "${fdrGarage}/SourceHanSans.ttc"
curl -L https://github.com/adobe-fonts/source-han-sans/blob/release/SuperOTC/SourceHanSans.ttc.zip\?raw\=true | bsdtar -xvf-
if [ ! -f "./SourceHanSans.ttc" ]
then
	echo "Fail to download font file."
	exit
fi
cp "${fdrGarage}/SourceHanSans.ttc" "${SystemFontsPath}/"
chown root:wheel "${SystemFontsPath}/SourceHanSans.ttc"
chmod 644 "${SystemFontsPath}/SourceHanSans.ttc"

#========================================
# Convert phase: CTPresetFallbacks.plist
#========================================

Plutil -convert xml1 "${WorkingDirectory}/CTPresetFallbacks.plist"

${PlistFileRegx} "-Bold" "Font-Medium" "Font-Bold" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} "-Heavy" "Font-Medium" "Font-Heavy" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} "-Heavy" "Font-Bold" "Font-Heavy" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} "-Light" "Font-Light" "Font-Normal" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} "-Thin" "Font-Thin" "Font-ExtraLight" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} "-Thin" "Font-UltraLight" "Font-ExtraLight" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} "-UltraLight" "Font-Thin" "Font-ExtraLight" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} "-UltraLight" "Font-UltraLight" "Font-ExtraLight" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} EntireString ".AppleTraditionalChineseFont" "SourceHanSansTC" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont" "SourceHanSansSC" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} EntireString ".AppleKoreanFont" "SourceHanSansK" "${WorkingDirectory}/CTPresetFallbacks.plist"
${PlistFileRegx} EntireString ".AppleJapaneseFont" "SourceHanSans" "${WorkingDirectory}/CTPresetFallbacks.plist"

chown root:wheel "${WorkingDirectory}/CTPresetFallbacks.plist"
chmod 644 "${WorkingDirectory}/CTPresetFallbacks.plist"

#===========================================
# Convert phase: DefaultFontFallbacks.plist
#===========================================

Plutil -convert xml1 "${WorkingDirectory}/DefaultFontFallbacks.plist"

${PlistFileRegx} EntireString ".AppleTraditionalChineseFont" "SourceHanSansTC" "${WorkingDirectory}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont" "SourceHanSansSC" "${WorkingDirectory}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString ".AppleKoreanFont" "SourceHanSansK" "${WorkingDirectory}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString ".AppleJapaneseFont" "SourceHanSans" "${WorkingDirectory}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString "STHeitiTC-Light" "SourceHanSansTC-Regular" "${WorkingDirectory}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString "STHeitiSC-Light" "SourceHanSansSC-Regular" "${WorkingDirectory}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString "AppleSDGothicNeo-Regular" "SourceHanSansK-Regular" "${WorkingDirectory}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString "HiraKakuProN-W3" "SourceHanSans-Regular" "${WorkingDirectory}/DefaultFontFallbacks.plist"

chown root:wheel "${WorkingDirectory}/DefaultFontFallbacks.plist"
chmod 644 "${WorkingDirectory}/DefaultFontFallbacks.plist"

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
