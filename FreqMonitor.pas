unit FreqMonitor;

interface

uses
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, Menus, Clipbrd;

type
  TfFreqMonitor = class(TForm)
    FMListBox: TListBox;
    FLPopupMenu: TPopupMenu;
    Clearlist1: TMenuItem;
    Savelisttofile1: TMenuItem;
    procedure Clearlist1Click(Sender: TObject);
    procedure FMListBoxDblClick(Sender: TObject);
    procedure Savelisttofile1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fFreqMonitor: TfFreqMonitor;

implementation

uses MainForm;

{$R *.dfm}

function CompareStringsAsIntegers(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := StrToInt(List[Index1]) - StrToInt(List[Index2]);
end;

procedure TfFreqMonitor.Clearlist1Click(Sender: TObject);
begin
  Frequencies.Clear;
  FMListBox.Items := Frequencies;
end;

procedure TfFreqMonitor.FMListBoxDblClick(Sender: TObject);
begin
  if FMListBox.ItemIndex >= 0 then
    Clipboard.AsText := FMListBox.Items[ FMListBox.ItemIndex ];
end;

procedure TfFreqMonitor.Savelisttofile1Click(Sender: TObject);
begin
  fMain.SaveDialog1.FileName := '';
  fMain.SaveDialog1.FilterIndex := 2;
  if fMain.SaveDialog1.Execute then begin
    Frequencies.Sorted := False;
    Frequencies.CustomSort(CompareStringsAsIntegers);
    Frequencies.SaveToFile(fMain.SaveDialog1.FileName);
    Frequencies.Sorted := True;
  end;
  fMain.SaveDialog1.FilterIndex := 1;
end;

end.
