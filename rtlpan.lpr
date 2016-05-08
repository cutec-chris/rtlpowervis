program rtlpan;

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces,Forms, // this includes the LCL widgetset
  MainForm in 'MainForm.pas' {Form1},
  FreqMonitor in 'FreqMonitor.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfFreqMonitor, fFreqMonitor);
  Application.Run;
end.
