' ================================================================
'  jupyter-lab.vbs - run jupyter-lab.cmd with NO console window.
'
'  A .cmd started at logon would flash a black window and leave it
'  sitting there; this runs it hidden, which is the closest Windows
'  has to a launchd agent running quietly in the background.
' ================================================================
Option Explicit

Dim fso, sh, here, cmdFile

Set fso = CreateObject("Scripting.FileSystemObject")
Set sh  = CreateObject("WScript.Shell")

here    = fso.GetParentFolderName(WScript.ScriptFullName)
cmdFile = here & "\jupyter-lab.cmd"

If Not fso.FileExists(cmdFile) Then
    MsgBox "Cannot find:" & vbCrLf & cmdFile & vbCrLf & vbCrLf & _
           "Keep jupyter-lab.vbs and jupyter-lab.cmd in the same folder.", _
           16, "jupyter-lab.vbs"
    WScript.Quit 1
End If

sh.CurrentDirectory = here
sh.Run """" & cmdFile & """", 0, False
