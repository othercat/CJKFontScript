CJKFontScript
=============

> <b>Please BE AWARE that Automatic De-Fib scripts were introduced since 2014Oct26(GMT+8),</b>

> You should run Automatic De-Fib scripts (in `AEDKit` folder) before running installer scripts here <b>if one of the following conditions have met</b>:

> - Font Fallbacks are not factorial (either modified or copied from elsewhere);<br>
> // If you want to recover modifications made by installer scripts here (Since 2014Oct26),<br>// the `restore.sh` should be your first choice (unless your backups are removed).
- STHeiti (SinoType Sans) is removed from your system.<br>(our scripts only move SinoType Sans, a.k.a. Kabun Gothic, into a hidden backup folder)

> <b>De-fib Scripts matches System's Build Number (e.g.:`14B25`, etc.).</b>

<b>Recent update "Ogiso Susumu" tested by Shiki Suen at 2014-December-04, MST.</b><br>
Minor updates may introduced, please check commit list.

Please make sure your plists are factorial before running these installer scripts,<br> otherwise you may want to run De-Fib scripts.

**Always Use `sudo bash install_XXXX.sh` to run installer scripts by Terminal.**<br>
// You should restart all of running applications after running these scripts,<br>
// or better close all applications except Terminal.

> **Install_Hiragino.sh uses:**<br>
`Hiragino Kaku Gothic Pro` as Traditional Chinese GUI font.<br>
`Hiragino Sans GB` as Simplified Chinese GUI font.<br>
<br>
> **Install_Hiragino-ProN.sh uses:**<br>
`Hiragino Kaku Gothic ProN` as Traditional Chinese GUI font.<br>
`Hiragino Sans GB` as Simplified Chinese GUI font.<br>
<br>
> **Install_Hiragino-GBOnly.sh uses:**<br>
`Hiragino Sans GB` as **both** Traditional and Simplified Chinese GUI font.<br>
<br>
> **For Install_SHS-AdobeOfficialSuperOTC.sh:**<br>
Simplified Chinese GUI uses `Source Han Sans SC` as its GUI font.<br>
Traditional Chinese GUI uses `Source Han Sans TC` as its GUI font.<br>
Korean GUI uses `Source Han Sans K` as its GUI font.<br>
Japanese GUI uses `Source Han Sans` as its GUI font.<br>
<br>
> **For Install_SHS-DeskInterfaceOnly.sh:**<br>
We use modified hidden font "SHSDeskInterface" with camouflage to let the system font read them as its first priority, but this **needs original CJK fonts' absence** (better only move STHeiti away, and this installer script could do that). Meanwhile, factorial font fallback plists still needs to be modified a little to let this fontset work in a better manner (could also be done by this installer script). //More Intel: https://github.com/ShikiSuen/SHSDeskInterface

</code></pre>
Run `sudo bash restore.sh` to restore fonts and settings from the backups created by installer scripts.

All of these scripts here need to run with `sudo` to gain administrative permissions.

The `safari.css` could be used if you want Safari follows system's font fallback settings.

PlistFileRegx binary's Source Code: <https://github.com/othercat/PlistFileRegx>


Please also take references from:<br><http://shikisuen.github.io/OSXCJKFontPlists/><br><http://shikisuen.github.io/OSXCJKFontPlists/CTPresetFallbackAnalysis.html>

Major Update History
=============
####2014Dec04(MST) Wave 4, Codename "Ogiso Susumu"####
These updates were introduced regarding to the last wave:

1. SHSDeskInterface updated, only its lineGap changed to 50 while other metrics are reverted to Adobe's factorial settings (thanks to Kobayashi Ken, a.k.a. Ken Lunde, the programmer of SHS, for his suggestion).

2. Since OS X Yosemite's stable release has already been 14B25, all concerned files in this repo and the OSXCJKFontPlists repo has been updated, incl. AEDKit Scripts.

3. Thanks to Wells Riley @ https://github.com/wellsriley/YosemiteSanFranciscoFont , his repo inspired me that the system font could be installed in "/Library/Fonts/" folder. This means that only `chown root:wheel` + `chmod 644` permission settings and `sudo atsutil databases -remove` are mandatory regarding to the installation of new system font files. Thus, we updated this repo and the OSXCJKFontPlists repo.

####2014Nov08(MST) Wave 3, Codename "Kitahara Haruki"####
These updates were introduced regarding to the last wave:

1. We added some siblings of Hiragino Sans installer scripts to allow people use Hiragino Kaku Gothic ProN or Hiragino Sans GB as their Traditional GUI font.

2. We have received mass complaints on SHS's defect as GUI fonts while renaming files in Finder with CJK characters introduced, and lots of people don't like SHS 1.001's exaggerated line gap in horizontal texts. That's why we introduce **SHSDeskInterface** project (https://github.com/ShikiSuen/SHSDeskInterface). This is a forked project from SHS. It's a hidden font with camouflage to let the system font read them as its first priority, but this needs original CJK fonts' absence (we will only move STHeiti away to the backup folder in our Installer Scripts). See intel **"For Install_SHS-DeskInterfaceOnly.sh:"** above for more intel.

3. AEDKit Scripts and `restore.sh` are updated with SHSDeskInterface's removal introduced.

####2014Oct26(MST) Wave 2, Codename "Tohma Kazusa"####
These bug fixes were introduced regarding to the First "Stable" Release:

1. We changed constant of PlistRegEx into variable to make sure PlistRegEx will be downloaded to the Working Directory, not the User Root folder `./`.
2. MD5 CheckSum process of PlistRegEx has been introduced.
3. Working Directory redefined as `/tmp/FontInstallationWorkingDir/`.
4. Mass fixes were introduced in order to avoid unpredictable errors like "script can not be executed under folders which contains `space` in their names".
5. AED(De-Fib) Scripts are now well-commented.

####2014Oct26(GMT+8) Wave 1, First Stable Release####
These bug fixes were introduced in recent days since this Git Project Starts:

1. Automatic De-Fib scripts have been introduced since this update, and will be updated if new factorial scripts are shipped with further Yosemite updates.
2. The previous version of those installer scripts use their current
directories as working directory, this may cause serious failure of downloading PlistRegEx and Source Han Sans correctly. We Fixed this issue by building a specific temporary working directory, and this directory will be removed if these new installer scripts
get their job finished.
3. Both Installer Scripts and `restore.sh` could now backup (move) and restore ttf STHeiti fonts (from `/Library/Fonts/`) correctly.
4. Comments are written neatly among Installer Scripts and `restore.sh`.
5. In order to let the `restore.sh` always reads the most-recent backups, We have updated backup methods: If most-recent backups detected while running Installer Scripts, the existed most-recent backups will be renamed by adding suffix with the current time stamp.
6. Both Installer Scripts and `restore.sh` will let you confirm before they perform "kill-finder + clean-font-cache + force-reboot".
7. Safari CSS file is introduced to let Apple Safari follows system's font fallback settings.
8. We fixed all of those "IF" syntax errors which could cause failure on copying Hiragino Fonts from `/Library/Fonts/` to System Font Folder.
9. The Installer Scripts now also translate `DefaultFontfallbacks.plist` into XML format before applying modifications.

[END].
