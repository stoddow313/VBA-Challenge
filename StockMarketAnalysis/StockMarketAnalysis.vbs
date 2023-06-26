Sub StockMarket_Analysis()

'Define all Variables

Dim Ticker As String
Dim year_open As Double
Dim year_close As Double
Dim Yearly_Change As Double
Dim Total_Stock_Volume As Double
Dim Percent_Change As Double
Dim start_data As Integer
Dim ws As Worksheet

'Loop and execute through all worksheets

For Each ws In Worksheets
    
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"
    
    start_data = 2
    previous_i = 1
    Total_Stock_Volume = 0
    
    EndRow = ws.Cells(Rows.Count, "A").End(xlUp).Row
    
    For i = 2 To EndRow
        
        If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
        
        Ticker = ws.Cells(i, 1).Value
        
        previous_i = previous_i + 1
        
        
        year_open = ws.Cells(previous_i, 3).Value
        year_close = ws.Cells(i, 6).Value
        
        
        For j = previous_i To i
            
            Total_Stock_Volume = Total_Stock_Volume + ws.Cells(j, 7).Value
            
        Next j
        
        If year_open = 0 Then
        
            Percent_Change = year_close
        
        Else
            
            Yearly_Change = year_close - year_open
            
            Percent_Change = Yearly_Change / year_open
            
        End If
        
        ws.Cells(start_data, 9).Value = Ticker
        ws.Cells(start_data, 10).Value = Yearly_Change
        ws.Cells(start_data, 11).Value = Percent_Change
        
        ws.Cells(start_data, 11).NumberFormat = "0.00%"
        ws.Cells(start_data, 12).Value = Total_Stock_Volume
        
        start_data = start_data + 1
        
        Total_Stock_Volume = 0
        Yearly_Change = 0
        Percent_Change = 0
        
        previous_i = i
    End If
    
   Next i
   
   kEndRow = ws.Cells(Rows.Count, "K").End(xlUp).Row
   
   Increase = 0
   Decrease = 0
   Greatest = 0
   
        For k = 3 To kEndRow
        
            last_k = k - 1
            
            current_k = ws.Cells(k, 11).Value
            
            previous_k = ws.Cells(last_k, 11).Value
            
            volume = ws.Cells(k, 12).Value
            
            previous_vol = ws.Cells(last_k, 12).Value
            
            If Increase > current_k And Increase > previous_k Then
                
                Increase = Increase
            
            ElseIf current_k > Increase And current_k > previous_k Then
            
                Increase = current_k
                
                increasename = ws.Cells(k, 9).Value
                
            ElseIf previous_k > Increase And previous_k > current_k Then
            
                Increase = previous_kaaaaaa
                
                increasename = ws.Cells(last_k, 9).Value
                
            End If
            
            If Decrease < current_k And Decrease < previous_k Then
            
                Decrease = Decrease
                
            ElseIf current_k < Increase And current_k < previous_k Then
                
                Decrease = current_k
                
                decreasename = ws.Cells(k, 9).Value
                
            ElseIf previous_k < Increase And previous_k < current_k Then
            
                Decrease = previous_k
                
                decreasename = ws.Cells(last_k, 9).Value
                
            End If
            
            If Greatest > volume And Greatest > previous_vol Then

                Greatest = Greatest

                
                greatest_name = ws.Cells(k, 9).Value

            ElseIf volume > Greatest And volume > previous_vol Then

                Greatest = volume

                
                greatestname = ws.Cells(k, 9).Value

            ElseIf previous_vol > Greatest And previous_vol > volume Then

                Greatest = previous_vol

                greatestname = ws.Cells(last_k, 9).Value

            End If

        Next k
  '--------------------------------------------------
    ' Assign names for greatest increase,greatest decrease, and  greatest volume

    ws.Range("N1").Value = "Column Name"
    ws.Range("N2").Value = "Greatest % Increase"
    ws.Range("N3").Value = "Greatest % Decrease"
    ws.Range("N4").Value = "Greatest Total Volume"
    ws.Range("O1").Value = "Ticker Name"
    ws.Range("P1").Value = "Value"

    'Get for greatest increase, greatest increase, and  greatest volume Ticker name
    
    ws.Range("O2").Value = increasename
    ws.Range("O3").Value = decreasename
    ws.Range("O4").Value = greatestname
    ws.Range("P2").Value = Increase
    ws.Range("P3").Value = Decrease
    ws.Range("P4").Value = Greatest

    'Greatest increase and decrease in percentage format

    ws.Range("P2").NumberFormat = "0.00%"
    ws.Range("P3").NumberFormat = "0.00%"


'--------------------------------------------------
' Conditional formatting columns colors

'The end row for column J

    jEndRow = ws.Cells(Rows.Count, "J").End(xlUp).Row


        For j = 2 To jEndRow

            'if greater than or less than zero
            If ws.Cells(j, 10) > 0 Then

                ws.Cells(j, 10).Interior.ColorIndex = 4

            Else

                ws.Cells(j, 10).Interior.ColorIndex = 3
            End If

        Next j

'Execute to next worksheet
Next ws
End Sub

