CJKFontScript
=============
This repo is currently exclusive for OS X Yosemite.

> Please go to the **release channel** if you want to find **package downloads**:<br>
> https://github.com/othercat/CJKFontScript/releases<br>

> **Alternative Download Mirrors**:<br>
> Baidu: http://pan.baidu.com/s/1o6kitqa<br>
> OneDrive: http://1drv.ms/1GPNOUK<br>

**Disclaimer**: 

> All modifications made by the tools provided in this repo are going to modify some specific system files. This may have some risk in a general sense. Meanwhile, we are trying our best to make them safe-to-use, but it doesn't mean that we are responsible for any kind of data loss by extreme circumstances.

> In some cases, the packages provided here may trigger some internal bugs of some common software (e.g.: Twitter for mac has compatibility issue with Source Han Sans, etc.)... We are definitely not responsible for such incompatible issues.

> Those BASH scripts provided in this GitHub repo certainly need **STABLE** access to GitHub Online. We will definitely not be responsible for any issues caused by your unstable access towards here. (That's why we introduce "packages" instead of bash scripts now, while those old bash scripts are still referable by accessing the commit history of this repo.)

**Please BE AWARE that Automatic De-Fib package was introduced since 2015Apr18(MST)**

> You could run Automatic De-Fib package (in `AEDKit` folder) if you encountered any problem after performing font modifications towards your system.

> **A special case**: You should always run Automatic De-Fib package prior to running any installer here if it is BASH-script-only.

<b>Recent update "Ibata Junzou" tested by Shiki Suen at 2015-May-07, GMT+8.</b><br>
Minor updates may introduced, please check commit list.

**Always Use `sudo bash install_XXXX.sh` to run installer scripts by Terminal.**<br>
// You should restart all of running applications after running these scripts,<br>
// or better close all applications except Terminal.

> **For Install_SHS-AdobeOfficialSuperOTC.sh:**<br>
Simplified Chinese GUI uses `Source Han Sans SC` as its GUI font.<br>
Traditional Chinese GUI uses `Source Han Sans TC` as its GUI font.<br>
Korean GUI uses `Source Han Sans K` as its GUI font.<br>
Japanese GUI uses `Source Han Sans` as its GUI font.<br>
<br>
> **Install_Hiragino.sh does:**<br>
Unattended installation, incl. Hiragino Font Package download and final reboot.<br>
<br>
> **Install_SHS-UI.sh does:**<br>
Unattended installation, incl. SHS-UI Font Package download and final reboot.<br>
<br>
> **Regarding HiraginoChineseGUIFontForYosemite.pkg, it uses:**<br>
`Hiragino Sans Old Typeface` as Traditional Chinese GUI font.\*<br>
`Hiragino Sans GB` as Simplified Chinese GUI font.<br>
\* Font modifier's name is written in the package.<br>
<br>
> **Regarding SHSUI-GUIFontForYosemite.pkg:**<br>
We use modified hidden font "SourceHanSansUI" separate from the Adobe's official build in order to deal with the bug that OS X never read LineGap in some cases (e.g. Filename under icons in Finder). Compare to the previous "SHSDeskInterface", this doesn't need original CJK fonts' absence `unless it is specified by the apps you are using (that's why we still move STHeiti away via the installation script)`. The factorial font plists must be modified to fit this fontset, and the installation package will apply the correctly modified plists on your system (just like what Hiragino Font Package does above). <br>//More Intel: https://github.com/ShikiSuen/SourceHanSansUI<br>
//Current release is compatible with Microsoft Office 2016 and Logic Pro X.

</code></pre>
Since we have AEDKit package, `restore.sh` is not needed and is removed from this repo.

All of these scripts here need to run with `sudo` to gain administrative permissions.

The `safari.css` could be used if you want Safari follows system's font fallback settings.

PlistFileRegx binary's Source Code: <https://github.com/othercat/PlistFileRegx>

Please also take references from:<br><http://shikisuen.github.io/OSXCJKFontPlists/><br><http://shikisuen.github.io/OSXCJKFontPlists/CTPresetFallbackAnalysis.html>

Major Update History
=============
####2015MAY07(GMT+8) Wave 9, Codename "Ibata Junzou" (井端潤三)####
These updates were introduced regarding to the wave 8:

1. In the previous update, all packages requires that the target system must be client distribution. This could let the installation failed on server distributions of OS X Yosemite. In this update, this restriction does not exist. If you have met installation failure on OS X Yosemite Server, this update should solve this issue.

2. In case of any unwanted data corruption while downloading, all packages are now zipped by the default archiver shipped with OS X Yosemite.

####2015Apr17(MST) Wave 8, Codename "Ochiai Yuriko" (落合由里子)####
These updates were introduced regarding to the wave 7:

1. This update is intended to let SourceHanSansUI follow up with Adobe Official SHS 1.002 update, but we had found a problem regarding exaggerated output file size of SourceHanSansUI during its SuperOTC compilation. Ken Lunde pointed out that it is necessary to do master compilation regarding some of those subfonts (which needs lots of hours per font file). Fortunately, we had figured out a way to compile those important subfonts simultaneously (which saved us days of time). Such fact made this release available much earlier than what we supposed.

2. Any font installation packages who removes STHeiti completely from the system will now move them into `~/.Trash` folder in lieu of their removal. Let users decide whether remove or not.

3. SourceHanSansUI will become an offline installation package called "SHS-UI CJK GUI Font Modification Package", just as how the Hiragino Chinese GUI Font Modification made. 

4. Till now, there will be only one installation script available regarding Source Han Sans Official SuperOTC installation. Thanks to @BlackGear who pointed out that there's a missing token in this script, it is fixed in this update.

####2015Apr17(MST) Wave 7, Codename "Takayanagi Akira" (高柳明)####
These updates were introduced regarding to the wave 6:

1. Apologies for introducing "755 instead of 644" privilege changes in "Seto Hiroko" update, that is not intended. I rechecked the default necesssary privilege settings used by Apple and have found that it is still 644. In this update, all 755 privilege settings are changed into 644.

2. Because there are still some places in the world couldn't have stable access to GitHub, we felt worry regarding the stability of installation due to any kinds of random issues. Besides, OS X, if retail version published, will use the same set of font fallback plists until next major version of OS X. Thus, we are introducing installer packages instead of online-install bash scripts. This could save lots of time and make things easier.

3. Source Han Sans 1.002 is coming, we won't remove bash scripts regarding SHS installations until our next major update (codename "Ochiai Yuriko"). But, we removed all other bash scripts and change Hiragino installation bash script into bash bootstrapper: it runs in unattended mode, download the Hiragino Chinese GUI Font Modification Package silently, install it silently, only prompts you just before the final reboot. If you still need to see those old bash scripts, please check the commit history of this repo.

4. From now on, all packages provided in this repo supports full-installation-via-terminal, and you could do unattended installation just as what install_Hiragino.sh does in this current update.

5. Hiragino Sans Old Typeface is introduced in the current Hiragino Chinese GUI Font Modification Package, and its modifier's name is written in the package (that name won't display if your system's GUI language is neither Simplified nor Traditional Chinese).

####2015Apr15(MST) Wave 6, Codename "Seto Hiroko" (瀬戸紘子)####
These updates were introduced regarding to the wave 5:

1. Based on what SAIONJI Natsume reported, the previous release of SourceHanSansUI was unable to display any glyph in certain UI elements of certain apps (incl. Microsoft Office 2016, Logic Pro X, etc.). After serious investigation, we finally found out that some UI elements in OS X are unable to show any glyph via those fonts which PostScript names begin with a decimal dot (this means that such PostScript name is hidden). Thus, we changed the PostScript names of SourceHanSansUI to make sure that they couldn't be treated as hidden fonts anymore: this could let SourceHanSansUI display properly in Microsoft Office 2016 and Logic Pro X.

2. Since OS X Yosemite's stable release has already been 14D131 (10.10.3) by the time this update is pushed, all concerned files in this repo and the OSXCJKFontPlists repo has been updated, incl. AEDKit Scripts.

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
These bug fixes were introduced regarding to the wave1:

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
5. In order to let the `restore.sh` always reads the most-recent backups, We updated backup methods: If most-recent backups detected while running Installer Scripts, the existed most-recent backups will be renamed by adding suffix with the current time stamp.
6. Both Installer Scripts and `restore.sh` will let you confirm before they perform "kill-finder + clean-font-cache + force-reboot".
7. Safari CSS file is introduced to let Apple Safari follows system's font fallback settings.
8. We fixed all of those "IF" syntax errors which could cause failure on copying Hiragino Fonts from `/Library/Fonts/` to System Font Folder.
9. The Installer Scripts now also translate `DefaultFontfallbacks.plist` into XML format before applying modifications.

[END].
