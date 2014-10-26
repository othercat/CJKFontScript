CJKFontScript
=============

> <b>Please BE AWARE that Automatic De-Fib scripts were introduced since 2014Oct26(GMT+8),</b>

> You should run Automatic De-Fib scripts before running installer scripts here <b>if one of the following conditions have met</b>:

> - Font Fallbacks are not factorial (either modified or copied from elsewhere);<br>
> // If you want to recover modifications made by installer scripts here (Since 2014Oct26),<br>// the `restore.sh` should be your first choice.
- STHeiti (SinoType Sans) is removed from your system.<br>(our scripts only move SinoType Sans, a.k.a. Kabun Gothic, into a hidden backup folder)

> <b>De-fib Scripts matches System's Build Number (e.g.:`14A389`, etc.).</b>



<b>All of these scripts here were tested by Shiki Suen at 2014-October-26, GMT+8.</b>

Please make sure your plists are factorial before running these installer scripts,<br> otherwise you may want to run De-Fib scripts.

Run `install_Hiragino.sh`	or `install_SHS.sh` to run installer scripts by Terminal,<br>
// You should restart all of running applications after running these scripts,<br>
// or better close all applications except Terminal.

Run `restore.sh` to restore fonts and settings from the backups created by installer scripts.

ALl of these scripts need to run with `sudo` to gain administrative permissions.

<b>Always follow the following rule to run these scripts by Terminal</b>:
<pre><code>sudo bash XXXXXXXX.sh</code></pre>

The `safari.css` could be used if you want Safari follows system's font fallback settings.

PlistFileRegx binary's Source Code: <https://github.com/othercat/PlistFileRegx>


Please also take references from:<br><http://shikisuen.github.io/OSXCJKFontPlists/><br><http://shikisuen.github.io/OSXCJKFontPlists/CTPresetFallbackAnalysis.html>

Update History
=============
####2014Oct26(GMT+8), First Stable Release####
These bug fixes were introduced in recent days since this Git Project Starts:

- Automatic De-Fib scripts have been introduced since this update, and will be updated if new factorial scripts are shipped with further Yosemite updates.
- The previous version of those installer scripts use their current
directories as working directory, this may cause serious failure of downloading PlistRegEx and Source Han Sans correctly. We Fixed this issue by building a specific temporary working directory, and this directory will be removed if these new installer scripts
get their job finished.
- Both Installer Scripts and `restore.sh` could now backup (move) and restore ttf STHeiti fonts (from `/Library/Fonts`) correctly.
- Comments are written neatly among Installer Scripts and `restore.sh`.
- In order to let the `restore.sh` always reads the most-recent backups, We have updated backup methods: If most-recent backups detected while running Installer Scripts, the existed most-recent backups will be renamed by adding suffix with the current time stamp.
- Both Installer Scripts and `restore.sh` will let you confirm before they perform "kill-finder + clean-font-cash + force-reboot".
- Safari CSS file is introduced to let Apple Safari follows system's font fallback settings.
- All of those "IF" syntax errors which could cause failure on copying Hiragino Fonts from `/Library/Fonts` to System Font Folder.
- The Installer Scripts now also translate `DefaultFontfallbacks.plist` into XML format before applying modifications.

[END].
