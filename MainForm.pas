unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Math, Vcl.Samples.Spin, IniFiles, VclTee.TeeGDIPlus, Character,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series, VCLTee.BubbleCh;

type
  TForm1 = class(TForm)
    StatusBar: TStatusBar;
    StartStop: TBitBtn;
    FromMHZ: TSpinEdit;
    TillMHZ: TSpinEdit;
    StepSize: TComboBox;
    Gain: TComboBox;
    PPM: TSpinEdit;
    ChooseDongle: TSpinEdit;
    DrawMaxPower: TCheckBox;
    BitBtn2: TBitBtn;
    AutoAxis: TCheckBox;
    Chart1: TChart;
    Series2: TLineSeries;
    Series1: TLineSeries;
    WaterFall: TPaintBox;
    procedure StartStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ResetMaxPowerLevel(Sender: TObject);
    procedure PressResetMaxPowerLevel(Sender: TObject; var Key: Char);
    procedure WaterFallMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure WaterFallPaint(Sender: TObject);
    procedure WaterFallMouseLeave(Sender: TObject);
    procedure WaterFallMouseEnter(Sender: TObject);
  private
    procedure Log(Band: String; Bin: String = ''; FFT: String = '');
    procedure MainLoop;
    procedure AddLineToWaterFall(Data: array of double; DataSize: integer);
    procedure RefreshWaterFall;
    procedure DrawWaterFallCursor(X, Y: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Ini: TIniFile;
  Processing: Boolean = False;
  MaxPowerReset: Boolean = False;
  AppDir: String;

  WFBitmap: TBitmap;
  WFCursorX: Integer = -1;
  WFCursorY: Integer = -1;
  DrawWFCursor: Boolean = False;

implementation

{$R *.dfm}

procedure TForm1.StartStopClick(Sender: TObject);
begin
  Processing := not Processing;
  if Processing then StartStop.Caption := 'STOP' else StartStop.Caption := 'START';
  if Processing then MainLoop();
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Ini := TIniFile.Create( ChangeFileExt(Application.ExeName, '.ini') );
  try
    Ini.WriteInteger('App', 'FromMHZ',  FromMHZ.Value);
    Ini.WriteInteger('App', 'TillMHZ',  TillMHZ.Value);
    Ini.WriteBool   ('App', 'DrawMax',  DrawMaxPower.Checked);
    Ini.WriteBool   ('App', 'AutoAxis', AutoAxis.Checked);
    Ini.WriteInteger('App', 'StepSize', StepSize.ItemIndex);
    Ini.WriteInteger('App', 'Gain',     Gain.ItemIndex);
    Ini.WriteInteger('App', 'PPM',      PPM.Value);
    Ini.WriteInteger('App', 'Dongle',   ChooseDongle.Value);
  finally
    Ini.Free;
  end;

  Processing := False;
  WFBitmap.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  AppDir := ExtractFilePath(Application.ExeName);

  Ini := TIniFile.Create( ChangeFileExt(Application.ExeName, '.ini') );
  try
    FromMHZ.Value :=        Ini.ReadInteger('App', 'FromMHZ', 64);
    TillMHZ.Value :=        Ini.ReadInteger('App', 'TillMHZ', 108);
    DrawMaxPower.Checked := Ini.ReadBool   ('App', 'DrawMax', False);
    AutoAxis.Checked :=     Ini.ReadBool   ('App', 'AutoAxis', False);
    StepSize.ItemIndex :=   Ini.ReadInteger('App', 'StepSize', 2);
    Gain.ItemIndex :=       Ini.ReadInteger('App', 'Gain', 0);
    PPM.Value :=            Ini.ReadInteger('App', 'PPM', 0);
    ChooseDongle.Value :=   Ini.ReadInteger('App', 'Dongle', 0);
  finally
    Ini.Free;
  end;

  WFBitmap := TBitmap.Create;
  WFBitmap.PixelFormat := pf24bit;
  WFBitmap.SetSize(1920, 100);

end;

function rgb2(z, min_z, max_z: double): TColor;
var
  g: Double;
begin
    g := (z - min_z) / (max_z - min_z);
    Result := RGB(Round(g*255), 50, 110); // RGB(Round(g*255), Round(g*255), 50);
end;

procedure TForm1.RefreshWaterFall;
begin
    WaterFall.Canvas.StretchDraw(
        WaterFall.Canvas.ClipRect,
        WFBitmap
    );
end;

procedure TForm1.AddLineToWaterFall(Data: array of double; DataSize: integer);
var
  i: integer;
  TempFall: TBitmap;
  min_z, max_z: double;
begin
  TempFall := TBitmap.Create;
  try
    TempFall.PixelFormat := pf24bit;
    TempFall.SetSize(DataSize, 1);

    // calculate min_z, max_z
    min_z := 0;
    max_z := -256;
    for i := 0 to DataSize do begin
      if min_z > Data[i] then min_z := Data[i];
      if max_z < Data[i] then max_z := Data[i];
    end;

    // draw pixels line
    for i := 0 to DataSize do
      TempFall.Canvas.Pixels[i, 0] := rgb2(Data[i], min_z, max_z);

    // shift old waterfall image
    WFBitmap.Canvas.CopyRect(
      Rect(0, 1, WFBitmap.Width, WFBitmap.Height),
      WFBitmap.Canvas,
      WFBitmap.Canvas.ClipRect
    );

    // draw tempfall to waterfall
    WFBitmap.Canvas.StretchDraw(
        Rect(0, 0, WFBitmap.Width, 1),
        TempFall
    );

    // draw waterfall to screen
    RefreshWaterFall;

  finally
    TempFall.Free;
  end;
end;

procedure TForm1.Log(Band: String; Bin: String = ''; FFT: String = '');
begin
  StatusBar.Panels[0].Text := Band;
  if Bin <> '' then
    StatusBar.Panels[1].Text := Bin;
  if FFT <> '' then
    StatusBar.Panels[2].Text := FFT;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  FileName: String;
begin
  Filename := IntToStr(FromMHZ.Value) + '-' + IntToStr(TillMHZ.Value) + '_' +
        StringReplace(TimeToStr(Now), ':', '', [rfReplaceAll]) + '_' +
        StringReplace(DateToStr(Now), FormatSettings.DateSeparator, '', [rfReplaceAll]) + '.bmp';
  Chart1.SaveToBitmapFile(AppDir + 'spectrum_' + Filename);
  WFBitmap.SaveToFile(AppDir + 'waterfall_' + Filename);
  Log('Spectrum and waterfall saved');
end;

function RemoveWhiteSpace(const s: string): string;
var
  i, j: Integer;
begin
  SetLength(Result, Length(s));
  j := 0;
  for i := 1 to Length(s) do begin
    if not TCharacter.IsWhiteSpace(s[i]) then begin
      inc(j);
      Result[j] := s[i];
    end;
  end;
  SetLength(Result, j);
end;

procedure TForm1.Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  tmpX, tmpY: Double;
  temp: String;
begin
  Chart1.Series[0].GetCursorValues(tmpx, tmpy);
  Temp := Chart1.Series[0].GetHorizAxis.LabelValue(tmpX);
  Temp := RemoveWhiteSpace( Temp );
  Chart1.Hint :=
    'Signal: ' + Chart1.Series[0].GetVertAxis.LabelValue(tmpY) + ' dB' + #13#10
    + Format('Frequency: %.3f MHz', [ StrToFloat( Temp ) / 1000000 ]);
end;

function ExecAndWait(const FileName,
                     Params: ShortString;
                     const WinState: Word): boolean; export;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: String;
begin
  CmdLine := FileName + ' ' + Params;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  with StartInfo do
  begin
    cb := SizeOf(StartInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
  end;
  Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,
                          CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                          PChar(ExtractFilePath(Filename)), StartInfo, ProcInfo);

  if Result then begin
    while True do begin
      if WaitForSingleObject(ProcInfo.hProcess, 5) = WAIT_OBJECT_0 then Break;
      Application.ProcessMessages;
    end;
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
end;

procedure TForm1.MainLoop;
var
  CommandLine, DataString, S, S2: String;
  SourceData, Data: TStringList;
  DataSize, DrawStep, DrawFreq, i: Integer;
  Power, MaxPower: Array of double;
  SpectrumStep, SpectrumStepSize: Double;
begin
// Flag to init MaxPower array
MaxPowerReset := True;

while Processing do begin

  Log('Scanning '
    + IntToStr(FromMHZ.Value) + '-'
    + IntToStr(TillMHZ.Value) + ' MHz...');

  // Scan using rtl_power
  CommandLine := '-f ' + IntToStr(FromMHZ.Value) + 'M:'
                       + IntToStr(TillMHZ.Value) + 'M:'
                       + StepSize.Text;
  CommandLine := CommandLine + ' -g ' + Gain.Text;
  CommandLine := CommandLine + ' -p ' + IntToStr(PPM.Value);
  CommandLine := CommandLine + ' -d ' + IntToStr(ChooseDongle.Value);

  ExecAndWait(
    AppDir + 'rtl_power.exe',
    CommandLine + ' -1 -i 1s scan.csv',
    SW_HIDE
    // SW_SHOWNORMAL
  );

  Data := TStringList.Create;
  SourceData := TStringList.Create;
  try

    Log('Parsing FFT data...');

    // Loading rtl_power data
    DataString := '';
    SourceData.LoadFromFile('scan.csv');
    for S in SourceData do begin
      S2 := Copy(S, Pos(',', S)+1, Length(S)-Pos(',', S));
      // cutting data before
      for i := 1 to 4 do
        S2 := Copy(S2, Pos(',', S2)+1, Length(S2)-Pos(',', S2));
      DataString := DataString + Trim(Copy(S2, Pos(',', S2)+1, Length(S2)-Pos(',', S2))) + ', ';
    end;
    DataString := Copy(DataString, 0, Length(DataString)-2);

    // Loading parsed lines as strings into Data
    Data.Clear;
    Data.Delimiter := ',';
    Data.DelimitedText := DataString;

    // Succesfully parse with current locale
    FormatSettings.DecimalSeparator := '.';

    // Calculating size of data
    DataSize := Data.Count - 1;
    SetLength(Power, DataSize);

    // Init MaxPower[array]
    SetLength(MaxPower, DataSize);
    if (MaxPowerReset) then begin
      MaxPowerReset := False;
      for i := 0 to DataSize do MaxPower[i] := -256;
    end;

    // Moving data to Power[array]
    for i := 0 to DataSize do begin
      if (Data[i]) = '-1.#J' then Data[i] := '-1.00';           // fix for -1.#J
      Power[i] := StrToFloat( Trim(Data[i]) );                  // populate power
      if (MaxPower[i] < Power[i]) then MaxPower[i] := Power[i]; // populate max power
    end;

    Log('Drawing chart...');

    // Calculate X axis
    SpectrumStepSize := (((TillMHZ.Value * 1000000) - (FromMHZ.Value * 1000000)) / DataSize);
    SpectrumStep := FromMHZ.Value * 1000000;

    // Draw to chart
    Chart1.Series[0].Clear;
    Chart1.Series[1].Clear;
    for i := 0 to DataSize do begin
      Chart1.Series[0].AddXY(SpectrumStep, Power[i], '', clBlue);

      if DrawMaxPower.Checked then
        Chart1.Series[1].AddXY(SpectrumStep, MaxPower[i], '', clRed);

      SpectrumStep := SpectrumStep + SpectrumStepSize;
    end;

    // Visibility of chart MaxPower
    if DrawMaxPower.Checked then
      Chart1.Series[1].Visible := True
    else
      Chart1.Series[1].Visible := False;

    // Automatic chart left axis
    if AutoAxis.Checked then begin
      Chart1.LeftAxis.Automatic := True;
    end else begin
      Chart1.LeftAxis.Automatic := False;
      Chart1.LeftAxis.Minimum := -120;
      Chart1.LeftAxis.Maximum := 0;
    end;

    // Draw line to waterfall
    AddLineToWaterFall(Power, DataSize);

    Log('Ready...',
      Format('Step: %.3f Hz', [SpectrumStepSize]),
      'FFT bins: ' + IntToStr(DataSize)
    );

  finally
    SourceData.Free;
    Data.Free;
  end;

  Application.ProcessMessages;
end;
end;

procedure TForm1.PressResetMaxPowerLevel(Sender: TObject; var Key: Char);
begin
  MaxPowerReset := True;
  Application.ProcessMessages;
end;

procedure TForm1.ResetMaxPowerLevel(Sender: TObject);
begin
  MaxPowerReset := True;
  Application.ProcessMessages;
end;

procedure TForm1.WaterFallMouseEnter(Sender: TObject);
begin
  DrawWFCursor := True;
end;

procedure TForm1.WaterFallMouseLeave(Sender: TObject);
begin
  DrawWFCursor := False;
  RefreshWaterfall;  // to remove red line
end;

procedure TForm1.WaterFallMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Freq: Double;
begin
  Freq := FromMHZ.Value + ( (TillMHZ.Value - FromMHZ.Value) / WaterFall.Width ) * X;
  WaterFall.Hint := Format('%.3f MHz', [Freq]);

  WFCursorX := X;
  WFCursorX := Y;
  DrawWaterFallCursor(X, Y);
end;

procedure TForm1.DrawWaterFallCursor(X, Y: Integer);
begin
  RefreshWaterFall;

  if DrawWFCursor then begin
    WaterFall.Canvas.Pen.Color := clRed;
    WaterFall.Canvas.MoveTo(X, 0);
    WaterFall.Canvas.LineTo(X, WaterFall.Height);

    WaterFall.Canvas.Font.Color := clLime;
    WaterFall.Canvas.Brush.Style := bsClear;
    WaterFall.Canvas.TextOut(X + 5, Y - 12, WaterFall.Hint);
  end;
end;

procedure TForm1.WaterFallPaint(Sender: TObject);
begin
  DrawWaterFallCursor(WFCursorX, WFCursorY);  // on form resize etc
end;

end.
