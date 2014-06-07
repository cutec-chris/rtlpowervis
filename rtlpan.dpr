program rtlpan;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  FreqMonitor in 'FreqMonitor.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
