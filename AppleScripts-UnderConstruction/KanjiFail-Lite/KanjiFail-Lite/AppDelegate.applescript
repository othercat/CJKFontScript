#   KanjiFail-Lite for Hiragino Sans
#   Hiragino Sans Deployment Script (AppleScript)
#
#   Get OS X's default Chinese GUI font replaced into Hiragino Sans.
#	(Simplified Chinese use Hiragino Sans GB, Traditional Chinese use Hiragino Kaku Pro)
#
#   @(#)  Repleace System Fallbacks Font to Hiragino Sans in the project plist.
#
#   Original Bash Script for SHS was composed by Richard Li,
#   Shiki Suen translated that Bash script into this Apple Script.
#
#   Tested by Shiki Suen on Oct 26, 2014, MST.
#   Reference: http://shikisuen.github.io/OSXCJKFontPlists/CTPresetFallbackAnalysis.html
#   Latest Scripts could be found here: https://github.com/othercat/CJKFontScript


script AppDelegate
	property parent : class "NSObject"
	
	-- IBOutlets
	property theWindow : missing value
	
	on applicationWillFinishLaunching_(aNotification)
        
        
        
		-- Insert code here to initialize your application before any files are opened
        #============================================
        # Public Instant Variables
        #============================================
        
        set fdrGarage to "/tmp/FontInstallationWorkingDir"
        set dirBackupPath to "${HOME}/.FactorialCJKFontSettingsBackup"
        set dirSystemFontsPath to "/System/Library/Fonts"
        set dirSysFallbackPlists to "/System/Library/Frameworks/CoreText.framework/Versions/A/Resources/"
        set cmdPlutil to "plutil"
        set cmdPlistFileRegx to "${fdrGarage}/plistFileRegx"
        set md5PlistFileRegX to "f4f6b442d93cda35a1aec25121318482"
        set locString to load script file "LocStrings.scpt"
        global lang
        
        #============================================
        # Language Settings
        #============================================
        
        set appDisplayLang to (choose from list {(appLang of 1033 of locString), (appLang of 1028 of locString), (appLang of 2052 of locString)} with title (appTitle of 2052 of locString) default items (appLang of 1033 of locString)) as string
        global currentlocString
        if appDisplayLang is equal to (appLang of 1033 of locString) as string then set lang to 1033
        if appDisplayLang is equal to (appLang of 1028 of locString) as string then set lang to 1028
        if appDisplayLang is equal to (appLang of 2052 of locString) as string then set lang to 2052
        
        set appTitle to (appTitle of lang of locString)
        set WelcomeMessage to (WelcomeMessage of 1033 of locString)
        set msgUserCancellation to (msgUserCancellation of lang of locString)
        set msgSudoAcquiredSuccess to (msgSudoAcquiredSuccess of lang of locString)
        set msgSudoAcquiredFailure to (msgSudoAcquiredFailure of lang of locString)

        
        #============================================
        # Welcome Message
        #============================================
        
        try
            display dialog WelcomeMessage as text with title appTitle
            on error errMsg number errNo
            display alert msgUserCancellation & "
            ( Code:" & errNo & " )"
            return
        end try
        
        #============================================
        # Privileges Requirements
        #============================================
        
        try
            do shell script "echo $'" & msgSudoAcquiredSuccess & "'" with administrator privileges
            # say msgSudoAcquiredSuccess
            on error errMsg number errNo
            display alert msgSudoAcquiredFailure & "
            ( Code:" & errNo & " )"
            return
        end try
        
        #============================================
        # Create Working Directory
        #============================================
        
        try
            try
                tell application "Finder" to set targetFolder to fdrGarage as alias
                on error -- no window
                do shell script "mkdir " & fdrGarage with administrator privileges
                do shell script "echo $'FOLDER CREATED'"
            end try
        end try
        
        
    
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script