CJKFontScript
=============
This repo has been obsoleted and is used for reference purposes only. Every update since Wave 10 are moved to the SHS-UI repo: https://github.com/ShikiSuen/SourceHanSansUI/

Besides, the current obsoleted repo will only provide scripts for OS X Yosemite ONLY.

> Please go to the **release channel** if you want to find **package downloads**:<br>
> https://github.com/ShikiSuen/SourceHanSansUI/releases/Latest/<br>

> **Alternative Download Mirrors**:<br>
> Baidu: http://pan.baidu.com/s/1o6kitqa<br>
> OneDrive: http://1drv.ms/1GPNOUK<br>

**Disclaimer**: 

> All modifications made by the tools provided in this repo are going to modify some specific system files. This may have some risk in a general sense. Meanwhile, we are trying our best to make them safe-to-use, but it doesn't mean that we are responsible for any kind of data loss by extreme circumstances.

> In some cases, the packages provided here may trigger some internal bugs of some common software... We are definitely not responsible for such incompatible issues.

> Those BASH scripts provided in this GitHub repo certainly need **STABLE** access to GitHub Online. We will definitely not be responsible for any issues caused by your unstable access towards here. (That's why we introduce "packages" instead of bash scripts now, while those old bash scripts are still referable by accessing the commit history of this repo.)

**Please BE AWARE that Automatic De-Fib package was introduced since 2015Apr18(MST)**

> You could run Automatic De-Fib package (in `AEDKit` folder) if you encountered any problem after performing font modifications towards your system.

> **A special case**: You should always run Automatic De-Fib package prior to running any installer here if it is BASH-script-only.

<b>Recent update "Arima Saki" tested by Shiki Suen at 2015-Jun-14, GMT+8.</b><br>
Minor updates may introduced, please check commit list.

**Always Use `sudo bash install_XXXX.sh` to run installer scripts by Terminal.**<br>
// You should restart all of running applications after running these scripts,<br>
// or better close all applications except Terminal.

> **For Install_SHS-AdobeOfficialSuperOTC.sh:**<br>
Simplified Chinese GUI uses `Source Han Sans SC` as its GUI font.<br>
Traditional Chinese GUI uses `Source Han Sans TC` as its GUI font.<br>
Korean GUI uses `Source Han Sans K` as its GUI font.<br>
Japanese GUI uses `Source Han Sans` as its GUI font.<br>

</code></pre>
Since we have AEDKit package, `restore.sh` is not needed and is removed from this repo.

All of these scripts here need to run with `sudo` to gain administrative permissions.

The `safari.css` could be used if you want Safari follows system's font fallback settings.

PlistFileRegx binary's Source Code: <https://github.com/othercat/PlistFileRegx>

Please also take references from:

- <https://github.com/ShikiSuen/SourceHanSansUI/wiki/>
- <http://shikisuen.github.io/OSXCJKFontPlists/>
- <http://shikisuen.github.io/OSXCJKFontPlists/CTPresetFallbackAnalysis.html>

Major Update History
=============
Moved to: https://github.com/ShikiSuen/SourceHanSansUI/wiki/Major-Update-History

[END].
