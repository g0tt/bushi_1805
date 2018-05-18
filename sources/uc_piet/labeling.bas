Private Sub LabelCodel()
  Dim i As Long, j As Long
  Dim maxLabel As Long
  Dim lookUpTable() As Long
  Dim centralCodel As Long, leftCodel As Long, upperCodel As Long
  Dim leftLabel As Long, upperLabel As Long
  Dim oldLabel As Long, newLabel As Long
  ReDim label((w + 2) * (h + 2))
  
  maxLabel = 0
  ReDim lookUpTable(0)
  
  For i = 1 To w
  For j = 1 To h
    centralCodel = codel(Plot(i, j))
    leftCodel = codel(Plot(i - 1, j))
    upperCodel = codel(Plot(i, j - 1))
    leftLabel = label(Plot(i - 1, j))
    upperLabel = label(Plot(i, j - 1))
    
    If centralCodel = leftCodel Then
      label(Plot(i, j)) = leftLabel
      If centralCodel = upperCodel Then
        If leftLabel < upperLabel Then
          lookUpTable(upperLabel) = leftLabel
        Else
          lookUpTable(leftLabel) = upperLabel
        End If
      End If
    ElseIf centralCodel = upperCodel Then
      label(Plot(i, j)) = upperLabel
    Else
      maxLabel = maxLabel + 1
      label(Plot(i, j)) = maxLabel
      ReDim Preserve lookUpTable(maxLabel)
      lookUpTable(maxLabel) = maxLabel
    End If
  Next j
  Next i
  
  For i = 1 To maxLabel
    j = i
    Do Until lookUpTable(j) = j
      j = lookUpTable(j)
    Loop
    lookUpTable(i) = j
  Next i
  
  newLabel = 1
  oldLabel = 1
  For i = 1 To maxLabel
    If lookUpTable(i) > oldLabel Then
      newLabel = newLabel + 1
      oldLabel = lookUpTable(i)
    End If
    For j = i To maxLabel
      If lookUpTable(j) = oldLabel Then
        lookUpTable(j) = newLabel
      End If
    Next j
  Next i
  
  For i = 1 To w
  For j = 1 To h
    label(Plot(i, j)) = lookUpTable(label(Plot(i, j)))
  Next j
  Next i
  
  ReDim codelCount(maxLabel)
  
  For i = 1 To w
  For j = 1 To h
    codelCount(label(Plot(i, j))) = codelCount(label(Plot(i, j))) + 1
  Next j
  Next i
End Sub