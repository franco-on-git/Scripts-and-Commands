# This pop-up box pauses script process until clicking Ok

#Create pop-up box with Ok button to continue
$oReturn = [System.Windows.Forms.Messagebox]::Show("Please select a "".txt"" or "".csv"" file at the next window...")
$oReturn