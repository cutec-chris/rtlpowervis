object fMain: TfMain
  Left = 533
  Height = 482
  Top = 99
  Width = 764
  Caption = 'rtl-sdr dongle panorama'
  ClientHeight = 482
  ClientWidth = 764
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  Position = poDesktopCenter
  ShowHint = True
  LCLVersion = '1.7'
  object WaterFall: TPaintBox
    Left = 4
    Height = 159
    Top = 298
    Width = 731
    Align = alClient
    BorderSpacing.Left = 4
    BorderSpacing.Right = 29
    Color = clBtnFace
    ParentColor = False
    ParentShowHint = False
    OnMouseEnter = WaterFallMouseEnter
    OnMouseLeave = WaterFallMouseLeave
    OnMouseMove = WaterFallMouseMove
    OnMouseWheelDown = WaterFallMouseWheelDown
    OnMouseWheelUp = WaterFallMouseWheelUp
    OnPaint = WaterFallPaint
  end
  object Splitter1: TSplitter
    Cursor = crVSplit
    Left = 0
    Height = 3
    Top = 295
    Width = 764
    Align = alTop
    OnMoved = Splitter1Moved
    ResizeAnchor = akTop
  end
  object StatusBar: TStatusBar
    Left = 0
    Height = 25
    Top = 457
    Width = 764
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
    SimpleText = 'ready'
    ShowHint = True
  end
  object Panel1: TPanel
    Left = 0
    Height = 41
    Top = 42
    Width = 764
    Align = alTop
    BevelOuter = bvNone
    ClientHeight = 41
    ClientWidth = 764
    TabOrder = 2
    object StartStop: TBitBtn
      Left = 3
      Height = 33
      Top = 4
      Width = 69
      Caption = 'START'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      OnClick = StartStopClick
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object FromMHZ: TSpinEdit
      Left = 104
      Height = 29
      Hint = 'Start scanning from, Hz'
      Top = 8
      Width = 136
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Increment = 1000000
      MaxValue = 0
      OnChange = FromMHZChange
      OnKeyPress = PressResetMaxPowerLevel
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 1090000000
    end
    object TillMHZ: TSpinEdit
      Left = 240
      Height = 29
      Hint = 'Scan to, Hz'
      Top = 8
      Width = 136
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Increment = 1000000
      MaxValue = 0
      OnChange = TillMHZChange
      OnKeyPress = PressResetMaxPowerLevel
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = 1090000000
    end
    object StepSize: TComboBox
      Left = 384
      Height = 24
      Hint = 'Scanning step size'
      Top = 9
      Width = 72
      AutoSize = False
      ItemHeight = 0
      ItemIndex = 2
      Items.Strings = (
        '1k'
        '5k'
        '10k'
        '25k'
        '50k'
        '100k'
        '1M'
      )
      OnChange = ResetMaxPowerLevel
      OnKeyPress = PressResetMaxPowerLevel
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = '10k'
    end
    object Gain: TComboBox
      Left = 528
      Height = 27
      Hint = 'Gain value'
      Top = 9
      Width = 63
      ItemHeight = 0
      ItemIndex = 19
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
        '49.6'
      )
      OnChange = ResetMaxPowerLevel
      OnKeyPress = PressResetMaxPowerLevel
      ParentShowHint = False
      ShowHint = True
      Style = csDropDownList
      TabOrder = 4
      Text = '36.4'
    end
    object PPM: TSpinEdit
      Left = 600
      Height = 24
      Hint = 'PPM correction value'
      Top = 10
      Width = 40
      MaxValue = 500
      MinValue = -500
      OnChange = ResetMaxPowerLevel
      OnKeyPress = PressResetMaxPowerLevel
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Value = 90
    end
    object ChooseDongle: TSpinEdit
      Left = 642
      Height = 24
      Hint = 'Dongle Nr#'
      Top = 10
      Width = 38
      OnChange = ResetMaxPowerLevel
      OnKeyPress = PressResetMaxPowerLevel
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Value = 1
    end
    object DrawMaxPower: TCheckBox
      Left = 760
      Height = 22
      Hint = 'Draw spectrum power maximums'
      Top = 11
      Width = 86
      Caption = 'Maximums'
      OnClick = AutoAxisClick
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
    object SavePicturesToFiles: TBitBtn
      Left = 848
      Height = 25
      Hint = 'Immediately save spectrum and waterfall to bitmap files'
      Top = 11
      Width = 40
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
        0000000000000000000000000000000000000000000000000000
      }
      OnClick = SavePicturesToFilesClick
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
    end
    object AutoAxis: TCheckBox
      Left = 688
      Height = 22
      Hint = 'Automatically adjust dB axis'
      Top = 11
      Width = 68
      Caption = 'Auto dB'
      OnClick = AutoAxisClick
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
    end
    object OptionsButton: TBitBtn
      Left = 72
      Height = 28
      Hint = 'Advanced program options'
      Top = 8
      Width = 26
      AutoSize = True
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
        12FF000000000000000000000000000000000000000000000000
      }
      OnClick = OptionsButtonClick
      TabOrder = 10
    end
    object TunerAGC: TCheckBox
      Left = 462
      Height = 22
      Hint = 'Use Tuner AGC when checked'
      Top = 11
      Width = 49
      Caption = 'AGC'
      OnClick = TunerAGCClick
      TabOrder = 11
    end
  end
  object Chart1: TChart
    Left = 0
    Height = 212
    Top = 83
    Width = 739
    AxisList = <    
      item
        Grid.Color = clGray
        TickColor = clWhite
        AxisPen.Color = clSilver
        Minors = <>
        Position = 5
        Title.LabelFont.Color = clWhite
        Title.LabelFont.Orientation = 900
        Title.Caption = 'dB'
      end    
      item
        Alignment = calBottom
        Minors = <>
        Title.Caption = 'Hz'
      end>
    BackColor = 7171437
    Foot.Brush.Color = clBtnFace
    Foot.Font.Color = clBlue
    Legend.Font.Color = clCream
    Title.Brush.Color = clBtnFace
    Title.Font.Color = clWhite
    Title.Text.Strings = (
      'TChart'
    )
    Toolset = ChartToolset1
    Align = alTop
    BorderSpacing.Right = 25
    ParentShowHint = False
    ShowHint = True
    object Series1: TLineSeries
      Marks.Visible = False
      LinePen.Color = clBlue
      Pointer.Visible = False
    end
    object Series2: TLineSeries
      Transparency = 77
      Marks.Visible = False
      Pointer.HorizSize = 1
      Pointer.VertSize = 1
      Pointer.Visible = False
    end
    object Series3: TLineSeries
      Marks.Visible = False
      LinePen.Color = 7929720
      LineType = ltNone
      Pointer.HorizSize = 3
      Pointer.OverrideColor = [ocBrush, ocPen]
      Pointer.Pen.Color = 11599792
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      ShowPoints = True
    end
  end
  object Panel2: TPanel
    Left = 0
    Height = 42
    Top = 0
    Width = 764
    Align = alTop
    BevelOuter = bvNone
    ClientHeight = 42
    ClientWidth = 764
    TabOrder = 4
    object cbPreset: TComboBox
      Left = 8
      Height = 27
      Top = 16
      Width = 397
      ItemHeight = 0
      TabOrder = 0
      Text = 'cbPreset'
    end
    object Label1: TLabel
      Left = 3
      Height = 14
      Top = 0
      Width = 36
      Caption = 'Preset'
      ParentColor = False
    end
  end
  object ScrollBar1: TScrollBar
    Left = 744
    Height = 159
    Top = 298
    Width = 14
    Anchors = [akTop, akRight, akBottom]
    Kind = sbVertical
    PageSize = 0
    TabOrder = 5
  end
  object PopupMenu1: TPopupMenu
    left = 24
    top = 352
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
      object MenuItem1: TMenuItem
        Caption = 'execute Remote'
        OnClick = MenuItem1Click
      end
      object Cropfactor1: TMenuItem
        Caption = 'Crop percent...'
        object Crop0: TMenuItem
          AutoCheck = True
          Caption = '0%'
          GroupIndex = 5
          RadioItem = True
        end
        object Crop10: TMenuItem
          AutoCheck = True
          Caption = '10%'
          GroupIndex = 5
          RadioItem = True
        end
        object Crop20: TMenuItem
          AutoCheck = True
          Caption = '20%'
          GroupIndex = 5
          RadioItem = True
        end
        object Crop30: TMenuItem
          AutoCheck = True
          Caption = '30%'
          GroupIndex = 5
          RadioItem = True
        end
        object Crop40: TMenuItem
          AutoCheck = True
          Caption = '40%'
          GroupIndex = 5
          RadioItem = True
        end
        object Crop50: TMenuItem
          AutoCheck = True
          Caption = '50%'
          GroupIndex = 5
          RadioItem = True
        end
        object Crop60: TMenuItem
          AutoCheck = True
          Caption = '60%'
          Checked = True
          GroupIndex = 5
          RadioItem = True
        end
        object Crop70: TMenuItem
          AutoCheck = True
          Caption = '70%'
          GroupIndex = 5
          RadioItem = True
        end
        object Crop80: TMenuItem
          AutoCheck = True
          Caption = '80%'
          GroupIndex = 5
          RadioItem = True
        end
        object Crop90: TMenuItem
          AutoCheck = True
          Caption = '90%'
          GroupIndex = 5
          RadioItem = True
        end
        object Crop100: TMenuItem
          AutoCheck = True
          Caption = '100%'
          GroupIndex = 5
          RadioItem = True
        end
      end
      object DirectSampling: TMenuItem
        Caption = 'Direct sampling'
        Hint = 'Use direct sampling instead of quadrature one'
      end
      object Enablepeakhold: TMenuItem
        Caption = 'Enable peak hold'
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
      end
      object BottomAxis: TMenuItem
        Caption = 'Show frequency axis (Hz)'
        Hint = 'Show bottom spectrum axis'
      end
      object LimitWaterFall: TMenuItem
        Caption = 'Limit waterfall to screen size'
        Hint = 'Enable this option to limit waterfall image resolution by its real screen size (otherwise 1920*1080)'
      end
      object DrawTimeMarker: TMenuItem
        Caption = 'Draw time marker'
        Hint = 'Draw time marker at the left side of waterfall'
      end
      object MarkPeaks: TMenuItem
        Caption = 'Mark peaks'
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
    DefaultExt = '.ini'
    Filter = 'rtl_panorama preset files|*.ini'
    left = 90
    top = 352
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.ini'
    Filter = 'rtl_panorama preset files|*.ini|text files|*.txt'
    left = 154
    top = 352
  end
  object ColorDialog1: TColorDialog
    Color = clBlack
    CustomColors.Strings = (
      'ColorA=000000'
      'ColorB=000080'
      'ColorC=008000'
      'ColorD=008080'
      'ColorE=800000'
      'ColorF=800080'
      'ColorG=808000'
      'ColorH=808080'
      'ColorI=C0C0C0'
      'ColorJ=0000FF'
      'ColorK=00FF00'
      'ColorL=00FFFF'
      'ColorM=FF0000'
      'ColorN=FF00FF'
      'ColorO=FFFF00'
      'ColorP=FFFFFF'
      'ColorQ=C0DCC0'
      'ColorR=F0CAA6'
      'ColorS=F0FBFF'
      'ColorT=A4A0A0'
    )
    left = 216
    top = 352
  end
  object ChartToolset1: TChartToolset
    left = 54
    top = 72
    object ChartToolset1DataPointCrosshairTool1: TDataPointCrosshairTool
      OnAfterMouseMove = ChartToolset1DataPointCrosshairTool1AfterMouseMove
    end
  end
end
