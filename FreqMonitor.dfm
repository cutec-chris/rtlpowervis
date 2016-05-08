object fFreqMonitor: TfFreqMonitor
  Left = 521
  Height = 296
  Top = 179
  Width = 199
  Caption = 'freq monitor'
  ClientHeight = 296
  ClientWidth = 199
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  LCLVersion = '1.7'
  object FMListBox: TListBox
    Left = 0
    Height = 296
    Hint = 'Double click = copy to clipboard'
    Top = 0
    Width = 199
    Align = alClient
    ItemHeight = 0
    OnDblClick = FMListBoxDblClick
    ParentShowHint = False
    PopupMenu = FLPopupMenu
    ScrollWidth = 197
    ShowHint = True
    TabOrder = 0
    TopIndex = -1
  end
  object FLPopupMenu: TPopupMenu
    left = 24
    top = 248
    object Clearlist1: TMenuItem
      Caption = 'Clear list'
      OnClick = Clearlist1Click
    end
    object Savelisttofile1: TMenuItem
      Caption = 'Save list to file...'
      OnClick = Savelisttofile1Click
    end
  end
end
