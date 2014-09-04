object Form1: TForm1
  Left = 0
  Top = 0
  ParentCustomHint = False
  Caption = 'rtl-sdr dongle panorama'
  ClientHeight = 419
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object WaterFall: TPaintBox
    Left = 0
    Top = 286
    Width = 764
    Height = 114
    ParentCustomHint = False
    Align = alClient
    Color = clBtnFace
    ParentColor = False
    ParentShowHint = False
    ShowHint = False
    OnMouseEnter = WaterFallMouseEnter
    OnMouseLeave = WaterFallMouseLeave
    OnMouseMove = WaterFallMouseMove
    OnPaint = WaterFallPaint
    ExplicitLeft = 1
    ExplicitWidth = 779
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 283
    Width = 764
    Height = 3
    Cursor = crVSplit
    Align = alTop
    OnMoved = Splitter1Moved
    ExplicitWidth = 117
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 400
    Width = 764
    Height = 19
    ParentCustomHint = False
    Panels = <
      item
        Text = 'Ready...'
        Width = 250
      end
      item
        Text = 'Step: 0 Hz'
        Width = 120
      end
      item
        Text = 'FFT bins'
        Width = 50
      end>
    ParentShowHint = False
    ShowHint = True
    SimpleText = 'ready'
  end
  object Chart1: TChart
    Left = 0
    Top = 41
    Width = 764
    Height = 242
    ParentCustomHint = False
    Legend.Visible = False
    MarginBottom = 0
    MarginLeft = 0
    MarginRight = 0
    MarginTop = 1
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.LabelsFormat.TextAlignment = taCenter
    BottomAxis.Title.Caption = 'Hz'
    DepthAxis.LabelsFormat.TextAlignment = taCenter
    DepthTopAxis.LabelsFormat.TextAlignment = taCenter
    LeftAxis.Axis.SmallSpace = 1
    LeftAxis.LabelsFormat.TextAlignment = taCenter
    LeftAxis.Title.Caption = 'dB'
    RightAxis.LabelsFormat.TextAlignment = taCenter
    TopAxis.LabelsFormat.TextAlignment = taCenter
    View3D = False
    Zoom.Pen.Mode = pmNotXor
    Align = alTop
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnMouseEnter = Chart1MouseEnter
    OnMouseLeave = Chart1MouseLeave
    OnMouseMove = Chart1MouseMove
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TLineSeries
      Marks.Visible = False
      SeriesColor = clBlue
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.Visible = False
      Brush.BackColor = clDefault
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.VertSize = 1
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Transparency = 77
    end
    object Series3: TPointSeries
      Marks.Visible = False
      SeriesColor = clLime
      ClickableLine = False
      Pointer.Brush.Gradient.EndColor = clLime
      Pointer.Gradient.EndColor = clLime
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 41
    Align = alTop
    TabOrder = 2
    object StartStop: TBitBtn
      Left = 3
      Top = 8
      Width = 75
      Height = 25
      ParentCustomHint = False
      Caption = 'START'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = StartStopClick
    end
    object FromMHZ: TSpinEdit
      Left = 130
      Top = 10
      Width = 82
      Height = 22
      Hint = 'Start scanning from, Hz'
      ParentCustomHint = False
      Increment = 1000000
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 1090000000
      OnChange = ResetMaxPowerLevel
      OnKeyPress = PressResetMaxPowerLevel
    end
    object TillMHZ: TSpinEdit
      Left = 215
      Top = 10
      Width = 82
      Height = 22
      Hint = 'Scan to, Hz'
      ParentCustomHint = False
      Increment = 1000000
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = 1090000000
      OnChange = ResetMaxPowerLevel
      OnKeyPress = PressResetMaxPowerLevel
    end
    object StepSize: TComboBox
      Left = 300
      Top = 10
      Width = 48
      Height = 21
      Hint = 'Scanning step size'
      ParentCustomHint = False
      ItemIndex = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = '10k'
      OnChange = ResetMaxPowerLevel
      OnKeyPress = PressResetMaxPowerLevel
      Items.Strings = (
        '1k'
        '5k'
        '10k'
        '25k'
        '50k'
        '100k'
        '1M')
    end
    object Gain: TComboBox
      Left = 424
      Top = 10
      Width = 47
      Height = 21
      Hint = 'Gain value'
      ParentCustomHint = False
      Style = csDropDownList
      ItemIndex = 19
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Text = '36.4'
      OnChange = ResetMaxPowerLevel
      OnKeyPress = PressResetMaxPowerLevel
      Items.Strings = (
        '0.0'
        '0.9'
        '1.4'
        '2.7'
        '3.7'
        '7.7'
        '8.7'
        '12.5'
        '14.4'
        '15.7'
        '16.6'
        '19.7'
        '20.7'
        '22.9'
        '25.4'
        '28.0'
        '29.7'
        '32.8'
        '33.8'
        '36.4'
        '37.2'
        '38.6'
        '40.2'
        '42.1'
        '43.4'
        '43.9'
        '44.5'
        '48.0'
        '49.6')
    end
    object PPM: TSpinEdit
      Left = 474
      Top = 10
      Width = 40
      Height = 22
      Hint = 'PPM correction value'
      ParentCustomHint = False
      MaxValue = 500
      MinValue = -500
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Value = 90
      OnChange = ResetMaxPowerLevel
      OnKeyPress = PressResetMaxPowerLevel
    end
    object ChooseDongle: TSpinEdit
      Left = 516
      Top = 10
      Width = 30
      Height = 22
      Hint = 'Dongle Nr#'
      ParentCustomHint = False
      MaxValue = 100
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Value = 1
      OnChange = ResetMaxPowerLevel
      OnKeyPress = PressResetMaxPowerLevel
    end
    object DrawMaxPower: TCheckBox
      Left = 634
      Top = 12
      Width = 68
      Height = 17
      Hint = 'Draw spectrum power maximums'
      ParentCustomHint = False
      Caption = 'Maximums'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = AutoAxisClick
    end
    object SavePicturesToFiles: TBitBtn
      Left = 718
      Top = 8
      Width = 40
      Height = 25
      Hint = 'Immediately save spectrum and waterfall to bitmap files'
      ParentCustomHint = False
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000C40E0000C40E00000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000515151515151515151515151515100005109090909
        0909090909090909510000519A9A9A099B49499B099A9A9A510000519A9A09A3
        494949499B099A9A510000519A9A09494949494949099A9A510000519A9A0949
        494949FF49099A9A510000519A9A09A449FFFF499B099A9A5100005109090909
        A44949A3090D0D09510000510909090909090909090DF9095100005151515151
        5151515151515151510000005109510000000000000000000000000051515100
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = SavePicturesToFilesClick
    end
    object AutoAxis: TCheckBox
      Left = 572
      Top = 12
      Width = 57
      Height = 17
      Hint = 'Automatically adjust dB axis'
      ParentCustomHint = False
      Caption = 'Auto dB'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = AutoAxisClick
    end
    object OptionsButton: TBitBtn
      Left = 84
      Top = 8
      Width = 40
      Height = 25
      Hint = 'Advanced program options'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000000000000000
        00000000000000000000000000000F0C05FF0E0B05FF00000000000000000D09
        05FF000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000005E4536FF5C4532FF100C06FF4C3426FF5E44
        33FF1F170FFF0000000000000000000000000000000000000000000000000000
        00001D160DFF33271BFF0F0900FF997360FFB28A76FF5D4936FF875B47FFCBA5
        95FF655E52FF0F0800FF140F07FF000000000000000000000000000000000000
        0000645245FFD9BAABFF846B57FFA4877AFFA9897DFFA58373FF987160FFB196
        87FF655341FF815844FF84614FFF251B12FF0000000000000000000000000702
        00FF211609FFC7B3A8FFD1BCB7FFC2AAA1FFBB9D8EFFBB9C8CFFBA9B8CFFA581
        73FFA17B6BFFA37E6FFFC6A596FF362A1FFF00000000000000001A120AFFB8AA
        A1FFAA9E93FFDCCFCDFFCBBAADFF886A4BFF403020FF2D2416FF4E3E31FFB59A
        8AFFAC8F81FFC2ABA0FF5E5143FF120C03FF0F0C05FF00000000181008FFB9AF
        A6FFFFFFFFFFF0ECECFF917254FF1B1207FF0000000000000000000000005141
        34FFCCB4AAFFB79C92FFA68C7CFFB39283FF5C4434FF120E07FF00000000190D
        02FFE5E0DCFFEBE1DAFF543922FF000000000000000000000000000000001A12
        09FFC8B7ABFFC8B7ADFFC2ABA2FFC5A295FF8A614CFF151008FF382E22FFE3D5
        C8FFE6E3DFFFDCCEC1FF48321DFF000000000000000000000000000000001910
        07FFD6C9C1FFE1D5CFFFAB9284FF251408FF161007FF00000000271F14FFA38E
        77FFC1B3A3FFF0EAE3FF80654DFF070300FF000000000000000000000000594E
        41FFFFFFFFFFEBE7E7FFDFD6D2FF786C5EFF181107FF00000000000000000600
        00FF80705BFFFBF3EFFFE4D6C9FF5C4C3BFF120B03FF130C03FF4F4435FFE5DE
        D6FFF0F1EFFFEBE6E6FFFBFAF9FFFFFFFFFF704E39FF00000000000000002F25
        17FFFFF3E5FFDAC9BBFFE4DAD1FFF0E6DEFFD1C5B8FFCFC3B8FFF4ECE4FFE9E3
        DBFFE6E1DEFFB5A49AFF271A0EFF574133FF302215FF0000000000000000160F
        09FF665443FF593D25FF9E8F7DFFF3ECE6FFE7DBCFFFE9E3D9FFD8CDC2FFDACD
        C2FFF0E9DFFFDED2C8FF2F2317FF000000000000000000000000000000000000
        00000000000000000000CDC0B4FFEBDBCDFF715338FFD1C5BBFFEFE4D9FF6354
        44FF6E5E4FFFFFECE4FF7D6557FF000000000000000000000000000000000000
        000000000000000000003E3227FF7D6349FF1B1106FF857866FFFFFFF1FF6B5C
        4FFF00000000372B20FF20160DFF000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000044372AFF251C
        12FF000000000000000000000000000000000000000000000000}
      TabOrder = 10
      OnClick = OptionsButtonClick
    end
    object TunerAGC: TCheckBox
      Left = 382
      Top = 12
      Width = 41
      Height = 17
      Hint = 'Use Tuner AGC when checked'
      Caption = 'AGC'
      TabOrder = 11
      OnClick = TunerAGCClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 24
    Top = 352
    object Loadpreset1: TMenuItem
      Caption = 'Load preset...'
      Hint = 'Load software settings from preset file'
      OnClick = Loadpreset1Click
    end
    object Savepreset1: TMenuItem
      Caption = 'Save preset...'
      Hint = 'Save current software settings to a preset file'
      OnClick = Savepreset1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Radio2: TMenuItem
      Caption = 'Rtl_power options...'
      object Cropfactor1: TMenuItem
        Caption = 'Crop percent...'
        object Crop0: TMenuItem
          Caption = '0%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
        object Crop10: TMenuItem
          Caption = '10%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
        object Crop20: TMenuItem
          Caption = '20%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
        object Crop30: TMenuItem
          Caption = '30%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
        object Crop40: TMenuItem
          Caption = '40%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
        object Crop50: TMenuItem
          Caption = '50%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
        object Crop60: TMenuItem
          Caption = '60%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
        object Crop70: TMenuItem
          Caption = '70%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
        object Crop80: TMenuItem
          Caption = '80%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
        object Crop90: TMenuItem
          Caption = '90%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
        object Crop100: TMenuItem
          Caption = '100%'
          RadioItem = True
          OnClick = InvertMenuitem
        end
      end
      object DirectSampling: TMenuItem
        Caption = 'Direct sampling'
        Hint = 'Use direct sampling instead of quadrature one'
        OnClick = InvertMenuitem
      end
      object Enablepeakhold: TMenuItem
        Caption = 'Enable peak hold'
        OnClick = InvertMenuitem
      end
    end
    object Colors1: TMenuItem
      Caption = 'Set colors...'
      object Spectrumgraphcolor1: TMenuItem
        Caption = 'Spectrum graph color...'
        Hint = 'Assign spectrum power color'
        OnClick = Spectrumgraphcolor1Click
      end
      object Spectrummaxcolor1: TMenuItem
        Caption = 'Spectrum max color...'
        Hint = 'Assign spectrum max power color'
        OnClick = Spectrummaxcolor1Click
      end
      object Waterfallcolor1: TMenuItem
        Caption = 'Waterfall color...'
        OnClick = Waterfallcolor1Click
      end
    end
    object Radio1: TMenuItem
      Caption = 'Visual settings...'
      object LeftAxis: TMenuItem
        Caption = 'Show level axis (dB)'
        Hint = 'Show left spectrum axis'
        OnClick = InvertMenuitem
      end
      object BottomAxis: TMenuItem
        Caption = 'Show frequency axis (Hz)'
        Hint = 'Show bottom spectrum axis'
        OnClick = InvertMenuitem
      end
      object LimitWaterFall: TMenuItem
        Caption = 'Limit waterfall to screen size'
        Hint = 
          'Enable this option to limit waterfall image resolution by its re' +
          'al screen size (otherwise 1920*1080)'
        OnClick = InvertMenuitem
      end
      object DrawTimeMarker: TMenuItem
        Caption = 'Draw time marker'
        Hint = 'Draw time marker at the left side of waterfall'
        OnClick = InvertMenuitem
      end
      object MarkPeaks: TMenuItem
        Caption = 'Mark peaks'
        OnClick = InvertMenuitem
      end
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Showfreqmonitor1: TMenuItem
      Caption = 'Show/hide freq monitor'
      OnClick = Showfreqmonitor1Click
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'ini'
    Filter = 'rtl_panorama preset files|*.ini'
    Left = 90
    Top = 352
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'ini'
    Filter = 'rtl_panorama preset files|*.ini|text files|*.txt'
    Left = 154
    Top = 352
  end
  object ColorDialog1: TColorDialog
    Left = 216
    Top = 352
  end
end
