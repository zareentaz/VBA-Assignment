Attribute VB_Name = "Module2"
Sub Stock()


Dim ws As Worksheet
Dim Ticker As String
'Dim Total_Stock_Volume As Double
Dim Summary_Table_Row As Integer

 For Each ws In Worksheets

   LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
   ws.Activate
   Total_Stock_Volume = 0
   ' Keep track of the location for each row/line in the summary table
   Summary_Table_Row = 2
   openyear = ws.Cells(2, 3).Value

 ws.Range("I1").Value = "Ticker"
 ws.Range("L1").Value = "Total Stock Volume"
 ws.Range("J1").Value = "Yearly change"
 ws.Range("K1").Value = "Percent change"


 For i = 2 To LastRow

   ' Check if we are still within the same value, if it is not...
   If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then

       closeyear = Cells(i, 6).Value
       Yearlychange = closeyear - openyear

               ws.Cells(Summary_Table_Row, 10).Value = Yearlychange

     ' Set the Ticker Value
     Ticker = ws.Cells(i, 1).Value

     ' Add to Total_Stock_Volume
     Total_Stock_Volume = Total_Stock_Volume + Cells(i, 7).Value

   ws.Range("J" & Summary_Table_Row).Value = Yearlychange
   ws.Range("J" & Summary_Table_Row).NumberFormat = "0.000000000"

   'Adding green to cell for positive change and red for negative change
               If Yearlychange < 0 Then
                   ws.Cells(Summary_Table_Row, 10).Interior.ColorIndex = 3
               Else
                   ws.Cells(Summary_Table_Row, 10).Interior.ColorIndex = 4
               End If

   'Percentage
     If openyear <> 0 Then
       perChange = (Yearlychange / openyear)
       'ws.Range("K" & Summary_Table_Row).Value = perChange
       'perChange = (Yearlychange * 100) / openyear
       ws.Cells(Summary_Table_Row, 11).NumberFormat = "0.00%"
           ws.Cells(Summary_Table_Row, 11).Value = perChange
     Else
       perChange = 0
       ws.Cells(Summary_Table_Row, 11).NumberFormat = "0.00%"
           ws.Cells(Summary_Table_Row, 11).Value = perChange
     End If

     ' Print Ticker in the Summary Table
     ws.Range("I" & Summary_Table_Row).Value = Ticker

     ' Print the Total_Stock_Volume to the Summary Table
     ws.Range("L" & Summary_Table_Row).Value = Total_Stock_Volume

     ' Add one to the summary table row
     Summary_Table_Row = Summary_Table_Row + 1



     ' Reset Total_Stock_Volume
     Total_Stock_Volume = 0
   openyear = ws.Cells(i + 1, 3).Value

   Else

     ' Add to the Total Stock Volume
     Total_Stock_Volume = Total_Stock_Volume + ws.Cells(i, 7).Value



     End If

     Next i

     Next ws


End Sub
