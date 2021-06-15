################################################################################
################################################################################
## Script description                                                         ##
## List All the Disabled User Accounts in Active Directory                    ##
## Name      : AD-All-Disabled-Accts.ps1                                      ##
## Version   : 0.1                                                            ##
## Date      :                                                                ##
## Language  : PowerShell cmd-lets                                            ##
## License   : MIT                                                            ##
## Owner     : M.G                                                            ##
## Authors   : M.G                                                            ##
################################################################################
################################################################################


Const ADS_UF_ACCOUNTDISABLE = 2
 
Set objConnection = CreateObject("ADODB.Connection")
objConnection.Open "Provider=ADsDSOObject;"
Set objCommand = CreateObject("ADODB.Command")
objCommand.ActiveConnection = objConnection
objCommand.CommandText = _
    "<GC://dc=XXX,dc=XXX>;(objectCategory=User)" & _
        ";userAccountControl,distinguishedName;subtree"  
Set objRecordSet = objCommand.Execute
 
intCounter = 0
Do Until objRecordset.EOF
    intUAC=objRecordset.Fields("userAccountControl")
    If intUAC AND ADS_UF_ACCOUNTDISABLE Then
        WScript.echo objRecordset.Fields("distinguishedName") & " is disabled"
        intCounter = intCounter + 1
    End If
    objRecordset.MoveNext
Loop
 
WScript.Echo VbCrLf & "A total of " & intCounter & " accounts are disabled."
 
objConnection.Close
