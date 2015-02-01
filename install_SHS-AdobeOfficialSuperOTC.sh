#!/bin/bash
#   Source Hans Sans Deployment Script,
#   Get OS X's default CJK GUI font replaced into Source Han Sans.
#
#   @(#)  Replace System Fallbacks Font to Source Han Sans in the project plist.
#   Original Script for SHS was composed by Richard Li, Modified by Shiki Suen
#   Enjoy! 
#   Tested by Shiki Suen on Feb, 01, 2015, MST.
#   Reference: http://shikisuen.github.io/OSXCJKFontPlists/CTPresetFallbackAnalysis.html
#   Latest Scripts could be found here: https://github.com/othercat/CJKFontScript

#============================================
# Public Instant Variables
#============================================

fdrGarage="/tmp/FontInstallationWorkingDir"
BackupPath="${HOME}/.FactorialCJKFontSettingsBackup"
SystemFontsPath="/System/Library/Fonts"
LibraryFontsPath="/Library/Fonts"
SysPlistsDir="/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/"
Plutil="plutil"
PlistFileRegx="${fdrGarage}/plistFileRegx"
plisttoolhash="f4f6b442d93cda35a1aec25121318482"

#============================================
# Privileges Requirements
#============================================

if [ $(id -u) != 0 ]
then
	echo "[SUDO command needed to execute this BASH script, ABORT MISSION.]"
	exit
fi

#============================================
# Create Working Directory
#============================================

if [ ! -d "${fdrGarage}" ]
then
	echo "[Making Working directory ${fdrGarage}.]"
	mkdir "${fdrGarage}"
fi

#============================================
# Download PlistFileRegX
#============================================

cd "${fdrGarage}"

if [ -f "${PlistFileRegx}" ] && [[ ! $(md5 -q "${PlistFileRegx}") = "${plisttoolhash}" ]]
then
    echo "[PlistFileRegx MD5 CheckSum ERROR and will be NUKED , Performing ReDOWNLOAD.]"
	rm -f "${PlistFileRegx}"
fi

if [ ! -f "${PlistFileRegx}" ]
then
	curl -L "https://github.com/othercat/CJKFontScript/raw/master/plistFileRegx?raw=true" -o "${fdrGarage}/plistFileRegx"
	if [ ! -f "${PlistFileRegx}" ]
	then
		echo "[Failed to download plistRegEx file, ABORT MISSION.]"
		exit
	fi
fi

chmod +x "${PlistFileRegx}"

#=======================================
# Backup Plists
#=======================================

if [ ! -d "${BackupPath}" ]
then
	echo "[Making Backup directory ${BackupPath}.]"
	mkdir "${BackupPath}"
fi

if [ -f "${BackupPath}/CTPresetFallbacks.plist.bak" ]
then
   mv "${BackupPath}/CTPresetFallbacks.plist.bak" "${BackupPath}/CTPresetFallbacks.plist.RenamedWhen`date +%Y%m%d_%H%M%S`.bak"
fi

cp "${SysPlistsDir}/CTPresetFallbacks.plist" "${BackupPath}/CTPresetFallbacks.plist.bak"

if [ -f "${BackupPath}/DefaultFontFallbacks.plist.bak" ]
then
   mv "${BackupPath}/DefaultFontFallbacks.plist.bak" "${BackupPath}/DefaultFontFallbacks.plist.RenamedWhen`date +%Y%m%d_%H%M%S`.bak"
fi

cp "${SysPlistsDir}/DefaultFontFallbacks.plist" "${BackupPath}/DefaultFontFallbacks.plist.bak"

#=====================================================================
# Source Han Sans Download and Install with Correct System Permission
#=====================================================================

cd "${fdrGarage}"

rm -f "${fdrGarage}/SourceHanSans.ttc"
curl -L "https://github.com/adobe-fonts/source-han-sans/raw/release/SuperOTC/SourceHanSans.ttc.zip?raw=true" -o "${fdrGarage}/SourceHanSans.zip"
bsdtar -xvf "${fdrGarage}/SourceHanSans.zip"
if [ ! -f "${fdrGarage}/SourceHanSans.ttc" ]
then
	echo "[Failed to download the latest Source Han Sans SuperOTC, ABORT MISSION.]"
	exit
fi
cp "${fdrGarage}/SourceHanSans.ttc" "${LibraryFontsPath}/"
chown root:wheel "${LibraryFontsPath}/SourceHanSans.ttc"
chmod 644 "{LibraryFontsPath}/SourceHanSans.ttc"

#========================================
# Convert phase: CTPresetFallbacks.plist
#========================================

Plutil -convert xml1 "${SysPlistsDir}/CTPresetFallbacks.plist"

${PlistFileRegx} "-Bold" "Font-Medium" "Font-Bold" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} "-Heavy" "Font-Medium" "Font-Heavy" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} "-Heavy" "Font-Bold" "Font-Heavy" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} "-Light" "Font-Light" "Font-Normal" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} "-Thin" "Font-Thin" "Font-ExtraLight" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} "-Thin" "Font-UltraLight" "Font-ExtraLight" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} "-UltraLight" "Font-Thin" "Font-ExtraLight" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} "-UltraLight" "Font-UltraLight" "Font-ExtraLight" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} EntireString ".AppleTraditionalChineseFont" "SourceHanSansTC" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont" "SourceHanSansSC" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} EntireString ".AppleKoreanFont" "SourceHanSansK" "${SysPlistsDir}/CTPresetFallbacks.plist"
${PlistFileRegx} EntireString ".AppleJapaneseFont" "SourceHanSans" "${SysPlistsDir}/CTPresetFallbacks.plist"

chown root:wheel "${SysPlistsDir}/CTPresetFallbacks.plist"
chmod 644 "${SysPlistsDir}/CTPresetFallbacks.plist"

#===========================================
# Convert phase: DefaultFontFallbacks.plist
#===========================================

Plutil -convert xml1 "${SysPlistsDir}/DefaultFontFallbacks.plist"

${PlistFileRegx} EntireString ".AppleTraditionalChineseFont" "SourceHanSansTC" "${SysPlistsDir}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString ".AppleSimplifiedChineseFont" "SourceHanSansSC" "${SysPlistsDir}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString ".AppleKoreanFont" "SourceHanSansK" "${SysPlistsDir}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString ".AppleJapaneseFont" "SourceHanSans" "${SysPlistsDir}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString "STHeitiTC-Light" "SourceHanSansTC-Regular" "${SysPlistsDir}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString "STHeitiSC-Light" "SourceHanSansSC-Regular" "${SysPlistsDir}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString "AppleSDGothicNeo-Regular" "SourceHanSansK-Regular" "${SysPlistsDir}/DefaultFontFallbacks.plist"
${PlistFileRegx} EntireString "HiraKakuProN-W3" "SourceHanSans-Regular" "${SysPlistsDir}/DefaultFontFallbacks.plist"

chown root:wheel "${SysPlistsDir}/DefaultFontFallbacks.plist"
chmod 644 "${SysPlistsDir}/DefaultFontFallbacks.plist"

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

mv -fv "${SystemFontsPath}/STHeiti Light.ttc" "${BackupPath}/STHeiti Light.ttc.bak"
mv -fv "${SystemFontsPath}/STHeiti Medium.ttc" "${BackupPath}/STHeiti Medium.ttc.bak"
mv -fv "${SystemFontsPath}/STHeiti Thin.ttc" "${BackupPath}/STHeiti Thin.ttc.bak"
mv -fv "${SystemFontsPath}/STHeiti UltraLight.ttc" "${BackupPath}/STHeiti UltraLight.ttc.bak"
mv -fv "${LibraryFontsPath}/华文细黑.ttf" "${BackupPath}/KabunGothic-Light.ttf.bak"
mv -fv "${LibraryFontsPath}/华文黑体.ttf" "${BackupPath}/KabunGothic-Medium.ttf.bak"

#=============================================================
# Remove Working Directory
#=============================================================

rm -rf "${fdrGarage}/"

#=============================================================
# Clean Font Cache and Force Reboot
#=============================================================

atsutil databases -remove
reboot
