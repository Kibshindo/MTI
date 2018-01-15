Attribute VB_Name = "Module2"
Sub HighlightSpecificValue()

Dim fnd As String, FirstFound As String
Dim FoundCell As Range, rng As Range
Dim myRange As Range, LastCell As Range

'What value do you want to find?
  fnd = InputBox("Je veux mettre en surbrillance les colonnes contenant...", "Highlight")
  
    'End Macro if Cancel Button is Clicked or no Text is Entered
      If fnd = vbNullString Then Exit Sub

Set myRange = ActiveSheet.UsedRange
Set LastCell = myRange.Cells(myRange.Cells.Count)
Set FoundCell = myRange.Find(what:=fnd, after:=LastCell)

'Test to see if anything was found
  If Not FoundCell Is Nothing Then
    FirstFound = FoundCell.Address
  Else
    GoTo NothingFound
  End If

Set rng = FoundCell

'Loop until cycled through all unique finds
  Do Until FoundCell Is Nothing
    'Find next cell with fnd value
      Set FoundCell = myRange.FindNext(after:=FoundCell)
    
    'Add found cell to rng range variable
      Set rng = Union(rng, FoundCell)
    
    'Test to see if cycled through to first found cell
      If FoundCell.Address = FirstFound Then Exit Do
      
  Loop

'Highlight Found cells yellow
  rng.Interior.Color = RGB(255, 255, 0)

'Report Out Message
  MsgBox rng.Cells.Count & " cell(s) were found containing: " & fnd

Exit Sub

'Error Handler
NothingFound:
  MsgBox "No cells containing: " & fnd & " were found in this worksheet"

End Sub
