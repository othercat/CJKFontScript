#!/bin/bash
#   Factorial Font Configuration & SinoType Gothic Online Recovery Script (De-Fib)
#	The Script version must matches OS X's build number. (Current: 14C109)
#   This Script needs access to GitHub Online.
#   Get OS X's default CJK font settings recovered online, not based on local backups.
#   This AED Script is composed by Shiki Suen
#   Enjoy! 
#   Tested by Shiki Suen on Feb, 01, 2015, MST.
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

#============================================
# SinoType Gothic Fonts Online Recovery
#============================================

sudo curl -L "https://github.com/ShikiSuen/OSXCJKFontPlists/blob/master/FactorialSTHeitiBackup/STHeiti%20Light.ttc?raw=true" -o "/System/Library/Fonts/STHeiti Light.ttc"
sudo curl -L "https://github.com/ShikiSuen/OSXCJKFontPlists/blob/master/FactorialSTHeitiBackup/STHeiti%20Medium.ttc?raw=true" -o "/System/Library/Fonts/STHeiti Medium.ttc"
sudo curl -L "https://github.com/ShikiSuen/OSXCJKFontPlists/blob/master/FactorialSTHeitiBackup/STHeiti%20Thin.ttc?raw=true" -o "/System/Library/Fonts/STHeiti Thin.ttc"
sudo curl -L "https://github.com/ShikiSuen/OSXCJKFontPlists/blob/master/FactorialSTHeitiBackup/STHeiti%20UltraLight.ttc?raw=true" -o "/System/Library/Fonts/STHeiti UltraLight.ttc"
sudo curl -L "https://github.com/ShikiSuen/OSXCJKFontPlists/blob/master/FactorialSTHeitiBackup/%E5%8D%8E%E6%96%87%E7%BB%86%E9%BB%91.ttf?raw=true" -o "/Library/Fonts/华文细黑.ttf"
sudo curl -L "https://github.com/ShikiSuen/OSXCJKFontPlists/blob/master/FactorialSTHeitiBackup/%E5%8D%8E%E6%96%87%E9%BB%91%E4%BD%93.ttf?raw=true" -o "/Library/Fonts/华文黑体.ttf"

#============================================
# Font Permission Settings Recovery
#============================================

sudo chown root:wheel "/System/Library/Fonts/STHeiti Light.ttc"
sudo chmod 644 "/System/Library/Fonts/STHeiti Light.ttc"
sudo chown root:wheel "/System/Library/Fonts/STHeiti Medium.ttc"
sudo chmod 644 "/System/Library/Fonts/STHeiti Medium.ttc"
sudo chown root:wheel "/System/Library/Fonts/STHeiti Thin.ttc"
sudo chmod 644 "/System/Library/Fonts/STHeiti Thin.ttc"
sudo chown root:wheel "/System/Library/Fonts/STHeiti UltraLight.ttc"
sudo chmod 644 "/System/Library/Fonts/STHeiti UltraLight.ttc"
sudo chown root:wheel "/Library/Fonts/华文细黑.ttf"
sudo chmod 644 "/Library/Fonts/华文细黑.ttf"
sudo chown root:wheel "/Library/Fonts/华文细黑.ttf"
sudo chmod 644 "/Library/Fonts/华文细黑.ttf"

#============================================
# Font Fallbacks Plists Recovery
#============================================

sudo curl -L "https://github.com/ShikiSuen/OSXCJKFontPlists/blob/master/Yosemite-10.10-14C109/FactorialPlists/CTPresetFallbacks.plist?raw=true" -o "/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/CTPresetFallbacks.plist"
sudo curl -L "https://github.com/ShikiSuen/OSXCJKFontPlists/blob/master/Yosemite-10.10-14C109/FactorialPlists/DefaultFontFallbacks.plist?raw=true" -o "/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/DefaultFontFallbacks.plist"
sudo chown root:wheel "/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/CTPresetFallbacks.plist"
sudo chmod 644 "/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/CTPresetFallbacks.plist"
sudo chown root:wheel "/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/DefaultFontFallbacks.plist"
sudo chmod 644 "/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/DefaultFontFallbacks.plist"

#=============================================================
# Remove Unnecessary Backup Files
#=============================================================

sudo rm -rf ~/".FactorialCJKFontSettingsBackup/"
sudo rm -rf "/tmp/FontInstallerTemporaryWorkingDir/"

#=============================================================
# Remove SHSDeskInterface
#=============================================================

sudo rm -f "/System/Library/Fonts/SHSDeskInterface.ttc"
sudo rm -f "/Library/Fonts/SHSDeskInterface.ttc"
sudo rm -f "/Library/SourceHanSansUI.ttc"

#=============================================================
# Clean Font Cache and Force Reboot
#=============================================================

sudo atsutil databases -remove
sudo reboot
