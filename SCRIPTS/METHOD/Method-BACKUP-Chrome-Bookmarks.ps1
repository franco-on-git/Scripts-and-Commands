$cbookmarkssource = "C:\Users\$env:USERNAME\AppData\Local\Google\Chrome\User Data\default\Bookmarks"
$cbookmarkstarget = "C:\Users\$env:USERNAME\[subdirectory]"

Copy-Item $cbookmarkssource "$cbookmarkstarget\Chrome_Bookmarks_$(Get-Date -format "yyyy_MM_dd")"