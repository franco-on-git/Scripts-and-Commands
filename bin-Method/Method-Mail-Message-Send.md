# REFERENCE: https://mailtrap.io/blog/powershell-send-email/

# QUICK SEND EXAMPLE 
```powershell
send-mailmessage -to rguilliman@imperium.com -from emperor.mankind@imperium.com -Subject "Primarch Regent" -Body "You need to take over, son" -smtpserver mailrouter.imperium.com 
```

## Send example, modify variable strings
```powershell

$From = "user@contoso.com"
$To = "user2@contoso.com", "jorah-mormont@contoso.com"
$CC = "<any cc>"
$Subject = "Script Results"
$Body = "<h2>Large Body Text</h2><br>"
$Body += "Regular Body Text"
$SMTPServer = "mailrouter.contoso.com"
$Attachment = "C:\Temp\contoso.jpg"

# Send message with variables
Send-MailMessage -From $From -to $To -Cc $CC -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SMTPServer -Attachments $Attachment
```
