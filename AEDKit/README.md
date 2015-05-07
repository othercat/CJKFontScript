CJKFontScript - AEDKit
=============

<b>Since Apr 18, 2015, the AEDKit becomes a pkg installation package.</b> We made such decision due to our concern regarding that there are some places in the world which couldn't have stable access to GitHub… such fact may ruin the recovery process while downloading factorial font files.

> If you don't trust this pkg, you could either use payload extractor (or similar tools) to reverse-engineer it or don't use it.

Currently, the AEDKit package is made only for OS X Yosemite.

<b>You could download this package via this URL</b>:
<pre><code>https://github.com/othercat/CJKFontScript/releases/download/Latest/YosemiteFactorialChineseGUIFontRecovery.pkg.zip</code></pre>
If you manually install this package (not via Terminal), the installer will prompt you to reboot your Mac.

<b>You could also perform unattended installation by using following Terminal command</b>:
<pre><code>sudo curl -L $'https://github.com/adobe-fonts/source-han-sans/raw/release/SuperOTC/SourceHanSans.ttc.zip?raw=true' -o ~/Desktop/YosemiteFactorialChineseGUIFontRecovery.pkg.zip
bsdtar -xvf ~/Desktop/YosemiteFactorialChineseGUIFontRecovery.pkg.zip
sudo installer -pkg ~/Desktop/YosemiteFactorialChineseGUIFontRecovery.pkg -target /</code></pre>
After successfully running those terminal commands above, you <b>have to reboot</b> your system as soon as possible.

END.


