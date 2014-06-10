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
  if Form1.OpenDialog1.Execute then
    Frequencies.SaveToFile(Form1.OpenDialog1.FileName);
end;

end.
