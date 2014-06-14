unit FreqMonitor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Menus, Clipbrd;

type
  TForm2 = class(TForm)
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
  Form2: TForm2;

implementation

uses MainForm;

{$R *.dfm}

function CompareStringsAsIntegers(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := StrToInt(List[Index1]) - StrToInt(List[Index2]);
end;

procedure TForm2.Clearlist1Click(Sender: TObject);
begin
  Frequencies.Clear;
  FMListBox.Items := Frequencies;
end;

procedure TForm2.FMListBoxDblClick(Sender: TObject);
begin
  if FMListBox.ItemIndex >= 0 then
    Clipboard.AsText := FMListBox.Items[ FMListBox.ItemIndex ];
end;

procedure TForm2.Savelisttofile1Click(Sender: TObject);
begin
  Form1.SaveDialog1.FileName := '';
  Form1.SaveDialog1.FilterIndex := 2;
  if Form1.SaveDialog1.Execute then begin
    Frequencies.Sorted := False;
    Frequencies.CustomSort(CompareStringsAsIntegers);
    Frequencies.SaveToFile(Form1.SaveDialog1.FileName);
    Frequencies.Sorted := True;
  end;
  Form1.SaveDialog1.FilterIndex := 1;
end;

end.
