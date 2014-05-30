object Form1: TForm1
  Left = 0
  Top = 0
  ParentCustomHint = False
  Caption = 'rtl-sdr dongle panorama'
  ClientHeight = 419
  ClientWidth = 779
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
    Width = 779
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
    ExplicitWidth = 778
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 283
    Width = 779
    Height = 3
    Cursor = crVSplit
    Align = alTop
    OnMoved = Splitter1Moved
    ExplicitWidth = 117
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 400
    Width = 779
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
    Width = 779
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
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 779
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
      Left = 83
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
      Left = 168
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
      Left = 253
      Top = 10
      Width = 48
      Height = 21
      Hint = 'Scanning step size'
      ParentCustomHint = False
      Style = csDropDownList
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
      Left = 315
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
      Left = 365
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
      Left = 407
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
      Left = 571
      Top = 12
      Width = 39
      Height = 17
      Hint = 'Draw spectrum power maximums'
      ParentCustomHint = False
      Caption = 'Max'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
    object SavePicturesToFiles: TBitBtn
      Left = 613
      Top = 8
      Width = 162
      Height = 25
      ParentCustomHint = False
      Caption = 'Save spectrum && waterfall'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = SavePicturesToFilesClick
    end
    object AutoAxis: TCheckBox
      Left = 446
      Top = 12
      Width = 57
      Height = 17
      Hint = 'Automatically adjust dB axis'
      ParentCustomHint = False
      Caption = 'Auto dB'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
    end
    object LeftAxis: TCheckBox
      Left = 506
      Top = 12
      Width = 29
      Height = 17
      Hint = 'Show level axis'
      Caption = 'dB'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
    end
    object BottomAxis: TCheckBox
      Left = 538
      Top = 12
      Width = 30
      Height = 17
      Hint = 'Show frequency axis'
      Caption = 'Hz'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
    end
  end
end
