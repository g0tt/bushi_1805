Private isSameBlock()

Private Sub checkNextCodel(x As Long, y As Long, pointerCodel)
  If Not isSameBlock(Plot(x, y)) And _
    codel(Plot(x, y)) = pointerCodel Then
    isSameBlock(Plot(x, y)) = True
    Call checkNextCodel(x - 1, y)
    Call checkNextCodel(x + 1, y)
    Call checkNextCodel(x, y - 1)
    Call checkNextCodel(x, y + 1)
  End If
End Sub
  
Private Sub GetSameBlock()  
  ReDim isSameBlock((w + 2) * (h + 2))
  Call checkNextCodel(pointer.x, pointer.y)
End Sub