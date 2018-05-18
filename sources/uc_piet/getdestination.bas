Private Function GetDestination() As Vector2
  Dim i As Long, j As Long
  Dim di As Long, dj As Long
  
  If codel(PlotVector2(pointer)) = 1 Then
    GetDestination = pointer
    Exit Function
  End If
  
  di = -dp.GetDirection.Y * cc
  dj = dp.GetDirection.X * cc
  
  If dp.GetDirection.X = 0 Then
    If dp.GetDirection.Y = 1 Then j = h + 1 Else j = 0
  Else
    If dp.GetDirection.X = 1 Then i = w + 1 Else i = 0
  End If
  
  Do
    If dp.GetDirection.X = 0 Then
      j = j - dp.GetDirection.Y
      If di = 1 Then i = w + 1 Else i = 0
    Else
      i = i - dp.GetDirection.X
      If dj = 1 Then j = h + 1 Else j = 0
    End If
    Do Until i < 0 Or w + 1 < i Or j < 0 Or h + 1 < j
      If label(Plot(i, j)) = label(PlotVector2(pointer)) Then
        GetDestination.X = i
        GetDestination.Y = j
        Exit Function
      End If
      i = i - di
      j = j - dj
    Loop
  Loop
End Function