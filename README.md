CJKFontScript
=============
This repo is currently exclusive for OS X Yosemite.

> <b>Please BE AWARE that Automatic De-Fib scripts were introduced since 2014Oct26(GMT+8),</b>

> You <b>should</b> run Automatic De-Fib scripts (in `AEDKit` folder) before running installer scripts here <b>if one of the following conditions have met</b>:

> - Font Fallbacks are not factorial (either modified or copied from elsewhere);<br>
> // If you want to recover modifications made by installer scripts here (Since 2014Oct26),<br>// the `restore.sh` should be your first choice (unless your backups are removed).
- STHeiti (SinoType Sans) is removed from your system.<br>(our scripts only move SinoType Sans, a.k.a. Kabun Gothic, into a hidden backup folder)

> <b>De-fib Scripts matches System's Build Number (e.g.:`14D131`, etc.).</b>

<b>Recent update "Seto Hiroko" tested by Shiki Suen at 2015-April-15, MST.</b><br>
Minor updates may introduced, please check commit list.

Please <b>make sure your plists are FACTORIAL before</b> running these installer scripts,<br> otherwise you MAY want to run De-Fib scripts.

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
> **For Install_SHS-UI.sh:**<br>
We use modified hidden font "SourceHanSansUI" separate from the Adobe's official build in order to deal with the bug that OS X never read LineGap in some cases (e.g. Filename under icons in Finder). Compare to the previous "SHSDeskInterface", this **doesn't need original CJK fonts' absence** `unless it is specified by the apps you are using (that's why we still move STHeiti away via the installation script)`. The factorial font plists must be modified to fit this fontset, and the installation script could finish that (just like what the script files do for Hiragino fonts above). <br>//More Intel: https://github.com/ShikiSuen/SourceHanSansUI<br>
//Current release is compatible with Microsoft Office 2016 and Logic Pro X.

</code></pre>
Run `sudo bash restore.sh` to restore fonts and settings from the backups created by installer scripts.

All of these scripts here need to run with `sudo` to gain administrative permissions.

The `safari.css` could be used if you want Safari follows system's font fallback settings.

PlistFileRegx binary's Source Code: <https://github.com/othercat/PlistFileRegx>


Please also take references from:<br><http://shikisuen.github.io/OSXCJKFontPlists/><br><http://shikisuen.github.io/OSXCJKFontPlists/CTPresetFallbackAnalysis.html>

Major Update History
=============
####2015Apr15(MST) Wave 6, Codename "Seto Hiroko" (瀬戸紘子)####
These updates were introduced regarding to the wave 5:

1. Based on what SAIONJI Natsume (西園寺棗) reported, the previous release of SourceHanSansUI was unable to display any glyph in certain UI elements of certain apps (incl. Microsoft Office 2016, Logic Pro X, etc.). After serious investigation, we finally found out that some UI elements in OS X are unable to show any glyph via those fonts which PostScript names begin with a decimal dot (this means that such PostScript name is hidden). Thus, we changed the PostScript names of SourceHanSansUI to make sure that they couldn't be treated as hidden fonts anymore: this could let SourceHanSansUI display properly in Microsoft Office 2016 and Logic Pro X.

2. Since OS X Yosemite's stable release has already been 14D131 (10.10.3) by the time this update is pushed, all concerned files in this repo and the OSXCJKFontPlists repo has been updated, incl. AEDKit Scripts.

3. `Not an update but one more thing to say`: I would like to hear your complaints if you use Hiragino Scripts and found any problem happened after repairing disk permissions. A GUI font must has disk permission same to `root:wheel 755`, but system's built-in disk utility could let HiraginoSansGB and Hiragino Kaku Gothic Pro (not ProN) lose such permission settings while it is repairing disk permissions. Since I have no solution regarding this hidden danger, I recommend people to manually keep their permission settings by running shell commands `sudo chown root:wheel /Library/Fonts/FONTNAME.otf` and `sudo chmod 755 /Library/Fonts/FONTNAME.otf` via Terminal.app until new ideas come out.

####2015Feb01(MST) Wave 5, Codename "Ogiso Setsuna" (小木曽雪菜)####
These updates were introduced regarding to the wave 4:

1. We have found that the camouflaged fontset "SHSDeskInterface" couldn't be always displayed and its display priority could still be robbed by Apple's official fonts (esp. You don't want to remove some of those fonts, such as Hiragino Kaku Gothic ProN). **In this update*, we will replace this set with "SourceHanSansUI" instead*. But STHeiti will still be moved away since some apps and browsers specified them as their default Chinese display font.

2. Since OS X Yosemite has serious problem regarding its UILabel elements (they omit the lineGap data, cause display malfunction among multi-line filenames in Finder if the display font has lineGap data), Based on SHSDeskInterface, we add the LineGap data onto the existing Ascender parameter and then we set the new LineGap data into Zero. //Reference: http://www.zhihu.com/question/27910232

3. Since OS X Yosemite's stable release has already been 14C109 (10.10.2) by the time this update is pushed, all concerned files in this repo and the OSXCJKFontPlists repo has been updated, incl. AEDKit Scripts.

####2014Dec04(MST) Wave 4, Codename "Ogiso Susumu" (小木曽晋)####
These updates were introduced regarding to the wave 3:

1. SHSDeskInterface updated, only its lineGap changed to "100" while other metrics are reverted to Adobe's factorial settings (thanks to Kobayashi Ken, a.k.a. Ken Lunde, the programmer of SHS, for his suggestion on pointing out which parameter should be modified).

2. Since OS X Yosemite's stable release has already been 14B25 (10.10.1) by the time this update is pushed, all concerned files in this repo and the OSXCJKFontPlists repo has been updated, incl. AEDKit Scripts.

3. Thanks to Wells Riley @ https://github.com/wellsriley/YosemiteSanFranciscoFont , his repo inspired me that the system font could be installed in "/Library/Fonts/" folder. This means that only `chown root:wheel` + `chmod 644` permission settings and `sudo atsutil databases -remove` are mandatory regarding to the installation of new system font files. Thus, we updated this repo and the OSXCJKFontPlists repo.

####2014Nov08(MST) Wave 3, Codename "Kitahara Haruki" (北原春希)####
These updates were introduced regarding to the wave 2:

1. We added some siblings of Hiragino Sans installer scripts to allow people use Hiragino Kaku Gothic ProN or Hiragino Sans GB as their Traditional Chinese GUI font.

2. We have received mass complaints on SHS's defect as GUI fonts while renaming files in Finder with CJK characters introduced, and lots of people don't like SHS 1.001's exaggerated line gap in horizontal texts. That's why we introduce **SHSDeskInterface** project. This is a forked project from SHS. It's a hidden font with camouflage to let the system font read them as its first priority, but this needs original CJK fonts' absence (we will only move STHeiti away to the backup folder in our Installer Scripts). See **"For Install_SHS-DeskInterfaceOnly.sh:"** above for more intel.

3. AEDKit Scripts and `restore.sh` are updated with SHSDeskInterface's removal introduced.

####2014Oct26(MST) Wave 2, Codename "Touma Kazusa" (冬馬和紗)####
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
