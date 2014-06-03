########################################################################
# Created By: Dmitri G. (2014)
########################################################################


#My CUSTOM Function HERE
function FNprocess( $object ){
    [array]$Global:arr1 = @()
    $progressBar1.Value = 100
  # $txtBoxMain.Clear()

  foreach ($file in $object.Data.GetFileDropList()){
    $Global:arr1 += $file
  # Name
    [string]$strFileN = Split-Path $file -Leaf
  # Path
  # [string]$pathN = Split-Path $file
    $txtBoxMain.AppendText($strFileN+[char]13+[char]10)
  }
}

function GenerateForm {

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
#endregion

#region Generated Form Objects
$mainForm = New-Object System.Windows.Forms.Form
$groupBox1 = New-Object System.Windows.Forms.GroupBox
$txtBoxCut = New-Object System.Windows.Forms.TextBox
$txtBoxBegin = New-Object System.Windows.Forms.TextBox
$lbl3 = New-Object System.Windows.Forms.Label
$lbl2 = New-Object System.Windows.Forms.Label
$btnStart = New-Object System.Windows.Forms.Button
$progressBar = New-Object System.Windows.Forms.ProgressBar
$lbl1 = New-Object System.Windows.Forms.Label
$txtBoxMain = New-Object System.Windows.Forms.TextBox
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events
$handler_btnStart_Click= 
{

########################################################################
# My CODE starting HERE
########################################################################

[int]$intCount=$txtBoxBegin.Text -as [int]
[int]$intCutWith=$txtBoxCut.Text -as [int]

if ($intCount -ne 0) {[bool]$boolFlag=$True}


$btnStart.Enabled = $false

foreach ($element in $arr1) {

    [string]$strElementN = Split-Path $element -Leaf

    if (($intCount -gt 0) -and ($intCount -lt 10)) {[string]$strCountN = "0$intCount"} else {[string]$strCountN = "$intCount"}

    $strElementN = $strElementN.Substring($intCutWith)

    if ($boolFlag) {rename-item $element -NewName "$strCountN $strElementN"} else {rename-item $element -NewName $strElementN}
    $intCount++
  }

  $Global:arr1.Clear()
  $txtBoxMain.AppendText([char]13+[char]10+"Renamed!"+[char]13+[char]10)
  $txtBoxMain.AppendText("Close the WINDOW... Have a GOOD DAY!!!"+[char]13+[char]10+[char]13+[char]10)
  $txtBoxMain.AppendText("Author: "+[char]0x00A9+"Dmitri G. (akaDimiG) 2014"+[char]13+[char]10)

}

$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
    # Correct the form look
    [System.Windows.Forms.Application]::EnableVisualStyles()

	$mainForm.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 484
$System_Drawing_Size.Width = 733
$mainForm.ClientSize = $System_Drawing_Size
$mainForm.DataBindings.DefaultDataSourceUpdateMode = 0
$mainForm.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",12,0,3,1)
$loc = Join-Path(Get-Location)"\rename128x128.ico"
$mainForm.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($loc)
$mainForm.MaximizeBox = $False
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 379
$System_Drawing_Size.Width = 513
$mainForm.MinimumSize = $System_Drawing_Size
$mainForm.Name = "mainForm"
$mainForm.StartPosition = 1
$mainForm.Text = "Renamer"

$groupBox1.Anchor = 14

$groupBox1.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 13
$System_Drawing_Point.Y = 383
$groupBox1.Location = $System_Drawing_Point
$groupBox1.Name = "groupBox1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 89
$System_Drawing_Size.Width = 707
$groupBox1.Size = $System_Drawing_Size
$groupBox1.TabIndex = 4
$groupBox1.TabStop = $False
$groupBox1.Text = "Control"

$mainForm.Controls.Add($groupBox1)
$txtBoxCut.Anchor = 6
$txtBoxCut.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 223
$System_Drawing_Point.Y = 45
$txtBoxCut.Location = $System_Drawing_Point
$txtBoxCut.Name = "txtBoxCut"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 28
$System_Drawing_Size.Width = 45
$txtBoxCut.Size = $System_Drawing_Size
$txtBoxCut.TabIndex = 7
$txtBoxCut.Text = "0"
$txtBoxCut.TextAlign = 2

$groupBox1.Controls.Add($txtBoxCut)

$txtBoxBegin.Anchor = 6
$txtBoxBegin.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 145
$System_Drawing_Point.Y = 45
$txtBoxBegin.Location = $System_Drawing_Point
$txtBoxBegin.Name = "txtBoxBegin"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 28
$System_Drawing_Size.Width = 45
$txtBoxBegin.Size = $System_Drawing_Size
$txtBoxBegin.TabIndex = 6
$txtBoxBegin.Text = "01"
$txtBoxBegin.TextAlign = 2

$groupBox1.Controls.Add($txtBoxBegin)

$lbl3.Anchor = 6
$lbl3.AutoSize = $True
$lbl3.DataBindings.DefaultDataSourceUpdateMode = 0
$lbl3.ForeColor = [System.Drawing.Color]::FromArgb(255,148,0,211)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 214
$System_Drawing_Point.Y = 20
$lbl3.Location = $System_Drawing_Point
$lbl3.Name = "lbl3"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 22
$System_Drawing_Size.Width = 90
$lbl3.Size = $System_Drawing_Size
$lbl3.TabIndex = 5
$lbl3.Text = "Cut BY"

$groupBox1.Controls.Add($lbl3)

$lbl2.Anchor = 6
$lbl2.AutoSize = $True
$lbl2.DataBindings.DefaultDataSourceUpdateMode = 0
$lbl2.ForeColor = [System.Drawing.Color]::FromArgb(255,148,0,211)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 133
$System_Drawing_Point.Y = 20
$lbl2.Location = $System_Drawing_Point
$lbl2.Name = "lbl2"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 22
$System_Drawing_Size.Width = 70
$lbl2.Size = $System_Drawing_Size
$lbl2.TabIndex = 4
$lbl2.Text = "Start AT"

$groupBox1.Controls.Add($lbl2)

$btnStart.Anchor = 6

$btnStart.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 6
$System_Drawing_Point.Y = 43
$btnStart.Location = $System_Drawing_Point
$btnStart.Name = "btnStart"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 32
$System_Drawing_Size.Width = 111
$btnStart.Size = $System_Drawing_Size
$btnStart.TabIndex = 1
$btnStart.Text = "Execute"
$btnStart.UseVisualStyleBackColor = $True
$btnStart.add_Click($handler_btnStart_Click)

$groupBox1.Controls.Add($btnStart)

$progressBar.Anchor = 10
$progressBar.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 528
$System_Drawing_Point.Y = 48
$progressBar.Location = $System_Drawing_Point
$progressBar.Name = "progressBar"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 173
$progressBar.Size = $System_Drawing_Size
$progressBar.Style = 2
$progressBar.TabIndex = 3

$groupBox1.Controls.Add($progressBar)


$lbl1.Anchor = 13
$lbl1.DataBindings.DefaultDataSourceUpdateMode = 0
$lbl1.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",16,0,3,1)
$lbl1.ForeColor = [System.Drawing.Color]::FromArgb(255,0,139,139)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 12
$System_Drawing_Point.Y = 9
$lbl1.Location = $System_Drawing_Point
$lbl1.Name = "lbl1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 72
$System_Drawing_Size.Width = 708
$lbl1.Size = $System_Drawing_Size
$lbl1.TabIndex = 2
$lbl1.Text = "For FILEs renaming DROP THEM into this WINDOW and PUSH `"Execute`""
$lbl1.TextAlign = 32

$mainForm.Controls.Add($lbl1)

$txtBoxMain.AllowDrop = $True
# Add Function call HERE
$txtBoxMain.add_DragEnter({FNprocess($_)})
$txtBoxMain.Anchor = 15
$txtBoxMain.BackColor = [System.Drawing.Color]::FromArgb(255,255,255,255)
$txtBoxMain.Cursor = [System.Windows.Forms.Cursors]::Arrow
$txtBoxMain.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 12
$System_Drawing_Point.Y = 84
$txtBoxMain.Location = $System_Drawing_Point
$txtBoxMain.Multiline = $True
$txtBoxMain.Name = "txtBoxMain"
$txtBoxMain.ReadOnly = $True
$txtBoxMain.ScrollBars = 3
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 293
$System_Drawing_Size.Width = 709
$txtBoxMain.Size = $System_Drawing_Size
$txtBoxMain.TabIndex = 0
$txtBoxMain.AppendText("DROP files HERE!"+[char]13+[char]10+[char]13+[char]10)

$mainForm.Controls.Add($txtBoxMain)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $mainForm.WindowState
#Init the OnLoad event to correct the initial state of the form
$mainForm.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$mainForm.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm
