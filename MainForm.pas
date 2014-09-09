unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, StrUtils,
  Vcl.ExtCtrls, Math, Vcl.Samples.Spin, IniFiles, VclTee.TeeGDIPlus, Character,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series, VCLTee.BubbleCh,
  Vcl.Menus;

type
  TForm1 = class(TForm)
    StatusBar: TStatusBar;
    Chart1: TChart;
    Series2: TLineSeries;
    Series1: TLineSeries;
    WaterFall: TPaintBox;
    Panel1: TPanel;
    StartStop: TBitBtn;
    FromMHZ: TSpinEdit;
    TillMHZ: TSpinEdit;
    StepSize: TComboBox;
    Gain: TComboBox;
    PPM: TSpinEdit;
    ChooseDongle: TSpinEdit;
    DrawMaxPower: TCheckBox;
    SavePicturesToFiles: TBitBtn;
    AutoAxis: TCheckBox;
    Splitter1: TSplitter;
    OptionsButton: TBitBtn;
    PopupMenu1: TPopupMenu;
    Loadpreset1: TMenuItem;
    Savepreset1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    N1: TMenuItem;
    LeftAxis: TMenuItem;
    BottomAxis: TMenuItem;
    LimitWaterFall: TMenuItem;
    ColorDialog1: TColorDialog;
    Spectrumgraphcolor1: TMenuItem;
    Spectrummaxcolor1: TMenuItem;
    DrawTimeMarker: TMenuItem;
    TunerAGC: TCheckBox;
    Waterfallcolor1: TMenuItem;
    N3: TMenuItem;
    Showfreqmonitor1: TMenuItem;
    MarkPeaks: TMenuItem;
    Series3: TPointSeries;
    Colors1: TMenuItem;
    Radio1: TMenuItem;
    Radio2: TMenuItem;
    DirectSampling: TMenuItem;
    Cropfactor1: TMenuItem;
    Crop0: TMenuItem;
    Crop10: TMenuItem;
    Crop20: TMenuItem;
    Crop30: TMenuItem;
    Crop40: TMenuItem;
    Crop50: TMenuItem;
    Crop60: TMenuItem;
    Crop70: TMenuItem;
    Crop80: TMenuItem;
    Crop90: TMenuItem;
    Crop100: TMenuItem;
    Enablepeakhold: TMenuItem;
    procedure StartStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SavePicturesToFilesClick(Sender: TObject);
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ResetMaxPowerLevel(Sender: TObject);
    procedure PressResetMaxPowerLevel(Sender: TObject; var Key: Char);
    procedure WaterFallMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure WaterFallPaint(Sender: TObject);
    procedure WaterFallMouseLeave(Sender: TObject);
    procedure WaterFallMouseEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Chart1MouseEnter(Sender: TObject);
    procedure Chart1MouseLeave(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure OptionsButtonClick(Sender: TObject);
    procedure Loadpreset1Click(Sender: TObject);
    procedure Savepreset1Click(Sender: TObject);
    procedure InvertMenuitem(Sender: TObject);
    procedure Spectrumgraphcolor1Click(Sender: TObject);
    procedure Spectrummaxcolor1Click(Sender: TObject);
    procedure TunerAGCClick(Sender: TObject);
    procedure Waterfallcolor1Click(Sender: TObject);
    procedure Showfreqmonitor1Click(Sender: TObject);
    procedure AutoAxisClick(Sender: TObject);
  private
    procedure AddLineToWaterFall;
    procedure CalculatePeaks;
    procedure DrawSP;
    procedure DrawWaterFallPicture;
    procedure DrawWF;
    procedure InitArrays(var DataSize: integer);
    procedure LoadPresetFromFile(F: String);
    function  LoadRtlPowerData(var Data: TStringList): integer;
    procedure Log(Band: String; Bin: String = ''; FFT: String = '');
    procedure MainLoop;
    function  PrepareCommandLine: String;
    procedure ProcessVisualSettings;
    procedure ProcessChart;
    procedure ParseRtlPowerData(var Data: TStringList; var DataSize: integer);
    function  RoundFreq(var Freq: Double): Integer;
    procedure SavePresetToFile(F: String);
    procedure UpdateFrequencies;
  public
  end;

var
  AppDir: String;
  Form1: TForm1;
  Ini: TIniFile;
  ScanCounter: Int64 = 0;
  Processing: Boolean = False;
  MaxPowerReset: Boolean = False;

  Freq, MaxPower, Power: Array of Double;
  Peak: Array of Boolean;

  WFBitmap: TBitmap;

  WFCursor: Boolean = False;
  WFCursorX: Integer = -1;
  WFCursorY: Integer = -1;

  SPCursor: Boolean = False;
  SPCursorX: Integer = -1;
  SPCursorY: Integer = -1;

  LevelColor: TColor = clBlue;
  MaxColor: TColor = clRed;
  WFColor: TColor = clGreen;

  Frequencies: TStringList;

  iMaxDb: Integer = 0;
  iMinDb: Integer = -120;

implementation

{$R *.dfm}

uses FreqMonitor;

procedure TForm1.StartStopClick(Sender: TObject);
begin
  Processing := not Processing;
  if Processing then begin
    MaxPowerReset := True;
    StartStop.Caption := 'STOP';
    MainLoop();
  end else
    StartStop.Caption := 'START';
end;

procedure TForm1.TunerAGCClick(Sender: TObject);
begin
  if TunerAGC.Checked then
    Gain.Enabled := False
  else
    Gain.Enabled := True;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SavePresetToFile( ChangeFileExt(Application.ExeName, '.ini') );
  Processing := False;
end;

procedure TForm1.SavePresetToFile(F: String);
begin
  Ini := TIniFile.Create(F);
  try
    Ini.WriteInteger('App', 'FromMHZ',    FromMHZ.Value);
    Ini.WriteInteger('App', 'TillMHZ',    TillMHZ.Value);
    Ini.WriteBool   ('App', 'TunerAGC',   TunerAGC.Checked);
    Ini.WriteBool   ('App', 'DrawMax',    DrawMaxPower.Checked);
    Ini.WriteBool   ('App', 'AutoAxis',   AutoAxis.Checked);
    Ini.WriteBool   ('App', 'LeftAxis',   LeftAxis.Checked);
    Ini.WriteBool   ('App', 'BottomAxis', BottomAxis.Checked);
    Ini.WriteBool   ('App', 'LimitWF',    LimitWaterFall.Checked);
    Ini.WriteBool   ('App', 'DrawTime',   DrawTimeMarker.Checked);
    Ini.WriteBool   ('App', 'MarkPeaks',  MarkPeaks.Checked);
    Ini.WriteBool   ('App', 'DSampling',  DirectSampling.Checked);
    Ini.WriteBool   ('App', 'EPeakHold',  EnablePeakHold.Checked);
    Ini.WriteString ('App', 'StepSizeT',  StepSize.Text);
    Ini.WriteInteger('App', 'Gain',       Gain.ItemIndex);
    Ini.WriteInteger('App', 'PPM',        PPM.Value);
    Ini.WriteInteger('App', 'Dongle',     ChooseDongle.Value);
    Ini.WriteInteger('App', 'SplitterY',  Chart1.Height);
    Ini.WriteInteger('App', 'LevelColor', LevelColor);
    Ini.WriteInteger('App', 'MaxColor',   MaxColor);
    Ini.WriteInteger('App', 'WFColor',    WFColor);

    Ini.WriteBool   ('App', 'Crop0',      Crop0.Checked);
    Ini.WriteBool   ('App', 'Crop10',     Crop10.Checked);
    Ini.WriteBool   ('App', 'Crop20',     Crop20.Checked);
    Ini.WriteBool   ('App', 'Crop30',     Crop30.Checked);
    Ini.WriteBool   ('App', 'Crop40',     Crop40.Checked);
    Ini.WriteBool   ('App', 'Crop50',     Crop50.Checked);
    Ini.WriteBool   ('App', 'Crop60',     Crop60.Checked);
    Ini.WriteBool   ('App', 'Crop70',     Crop70.Checked);
    Ini.WriteBool   ('App', 'Crop80',     Crop80.Checked);
    Ini.WriteBool   ('App', 'Crop90',     Crop90.Checked);
    Ini.WriteBool   ('App', 'Crop100',    Crop100.Checked);
  finally
    Ini.Free;
  end;
end;

procedure TForm1.Showfreqmonitor1Click(Sender: TObject);
begin
  Form2.Visible := not Form2.Visible;
end;

procedure TForm1.Loadpreset1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    LoadPresetFromFile(OpenDialog1.FileName);
end;

procedure TForm1.LoadPresetFromFile(F: String);
begin
  Ini := TIniFile.Create(F);
  try
    FromMHZ.Value :=        Ini.ReadInteger('App', 'FromMHZ', 64000000);
    TillMHZ.Value :=        Ini.ReadInteger('App', 'TillMHZ', 108000000);
    TunerAGC.Checked :=     Ini.ReadBool   ('App', 'TunerAGC', False);
    DrawMaxPower.Checked := Ini.ReadBool   ('App', 'DrawMax', False);
    AutoAxis.Checked :=     Ini.ReadBool   ('App', 'AutoAxis', False);
    LeftAxis.Checked :=     Ini.ReadBool   ('App', 'LeftAxis', True);
    BottomAxis.Checked :=   Ini.ReadBool   ('App', 'BottomAxis', True);
    LimitWaterFall.Checked := Ini.ReadBool ('App', 'LimitWF', False);
    DrawTimeMarker.Checked := Ini.ReadBool ('App', 'DrawTime', False);
    MarkPeaks.Checked :=    Ini.ReadBool   ('App', 'MarkPeaks', False);
    DirectSampling.Checked := Ini.ReadBool ('App', 'DSampling', False);
    EnablePeakHold.Checked := Ini.ReadBool ('App', 'EPeakHold', False);
    StepSize.Text :=        Ini.ReadString ('App', 'StepSizeT', '100k');
    Gain.ItemIndex :=       Ini.ReadInteger('App', 'Gain', 0);
    PPM.Value :=            Ini.ReadInteger('App', 'PPM', 0);
    ChooseDongle.Value :=   Ini.ReadInteger('App', 'Dongle', 0);
    Chart1.Height :=        Ini.ReadInteger('App', 'SplitterY', 250);
    LevelColor :=           Ini.ReadInteger('App', 'LevelColor', clBlue);
    MaxColor :=             Ini.ReadInteger('App', 'MaxColor', clRed);
    WFColor :=              Ini.ReadInteger('App', 'WFColor', clRed);

    Crop0.Checked :=        Ini.ReadBool   ('App', 'Crop0', False);
    Crop10.Checked :=       Ini.ReadBool   ('App', 'Crop10', False);
    Crop20.Checked :=       Ini.ReadBool   ('App', 'Crop20', False);
    Crop30.Checked :=       Ini.ReadBool   ('App', 'Crop30', False);
    Crop40.Checked :=       Ini.ReadBool   ('App', 'Crop40', False);
    Crop50.Checked :=       Ini.ReadBool   ('App', 'Crop50', False);
    Crop60.Checked :=       Ini.ReadBool   ('App', 'Crop60', False);
    Crop70.Checked :=       Ini.ReadBool   ('App', 'Crop70', False);
    Crop80.Checked :=       Ini.ReadBool   ('App', 'Crop80', False);
    Crop90.Checked :=       Ini.ReadBool   ('App', 'Crop90', False);
    Crop100.Checked :=      Ini.ReadBool   ('App', 'Crop100', False);

    iMaxDb :=               Ini.ReadInteger('App', 'MaxDb', 0);
    iMinDb :=               Ini.ReadInteger('App', 'MinDb', -120);
  finally
    Ini.Free;
  end;

  MaxPowerReset := True;
  TunerAGCClick(Self);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  AppDir := ExtractFilePath(Application.ExeName);

  LoadPresetFromFile( ChangeFileExt(Application.ExeName, '.ini') );

  WFBitmap := TBitmap.Create;
  WFBitmap.PixelFormat := pf24bit;
  if LimitWaterFall.Checked then
    WFBitmap.SetSize(WaterFall.Width, WaterFall.Height)
  else
    WFBitmap.SetSize(1920, 1080);

  Frequencies := TStringList.Create;
  Frequencies.Sorted := True;
  Frequencies.Duplicates := dupIgnore;

  OpenDialog1.InitialDir := AppDir;
  SaveDialog1.InitialDir := AppDir;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Frequencies.Free;
  WFBitmap.Free;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if Form1.Height <= Chart1.Height + 100 then
    if Form1.Height > 160 then
      Chart1.Height := Form1.Height - 150;
end;

procedure TForm1.InvertMenuitem(Sender: TObject);
begin
  (Sender as TMenuItem).Checked := not (Sender as TMenuItem).Checked;
end;

function CalcRGB(z, min_z, max_z: double): TColor;
var
  coeff: Double;
  color: LongInt;
  r, g, b: Byte;
begin
  try
    coeff := (z - min_z) / (max_z - min_z);
  except
    coeff := 1;
  end;
  color := ColorToRGB(WFColor);
  r := color; g := color shr 8; b := color shr 16;
  Result := RGB(Round(coeff*r), Round(coeff*g), 110);
end;

procedure TForm1.DrawWaterFallPicture;
begin
  if LimitWaterFall.Checked then
    WFBitmap.SetSize(WaterFall.Width, WaterFall.Height)
  else
    WFBitmap.SetSize(1920, 1080);

  WaterFall.Canvas.StretchDraw(
      WaterFall.Canvas.ClipRect,
      WFBitmap
  );
end;

procedure TForm1.AddLineToWaterFall;
var
  i: integer;
  TempFall: TBitmap;
  min_z, max_z: double;
begin
  TempFall := TBitmap.Create;
  try
    TempFall.PixelFormat := pf24bit;
    TempFall.SetSize(High(Power) + 1, 1);

    // calculate min_z, max_z
    min_z := 0;
    max_z := -120;
    for i := 0 to High(Power) do begin
      if min_z > Power[i] then min_z := Power[i];
      if max_z < Power[i] then max_z := Power[i];
    end;

    // draw pixels line
    for i := 0 to High(Power) do
      TempFall.Canvas.Pixels[i, 0] := CalcRGB(Power[i], min_z, max_z);

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

    // draw time marker
    if (DrawTimeMarker.Checked) then
      if (ScanCounter mod 20 = 0) then begin
        WFBitmap.Canvas.Font.Color := clGreen;
        WFBitmap.Canvas.Brush.Style := bsClear;
        WFBitmap.Canvas.TextOut(2, 1, TimeToStr(Now));
      end;
  finally
    TempFall.Free;
  end;
end;

procedure TForm1.Log(Band: String; Bin: String = ''; FFT: String = '');
begin
  if Band <> '' then
  StatusBar.Panels[0].Text := Band;
  if Bin <> '' then
    StatusBar.Panels[1].Text := Bin;
  if FFT <> '' then
    StatusBar.Panels[2].Text := FFT;
end;

procedure TForm1.SavePicturesToFilesClick(Sender: TObject);
var
  FileName: String;
begin
  Filename := IntToStr(FromMHZ.Value) + '-' + IntToStr(TillMHZ.Value) + '_' +
        StringReplace(TimeToStr(Now), ':', '', [rfReplaceAll]) + '_' +
        StringReplace(DateToStr(Now),
          FormatSettings.DateSeparator, '', [rfReplaceAll]) + '.bmp';
  Chart1.SaveToBitmapFile(AppDir + 'spectrum_' + Filename);
  WFBitmap.SaveToFile(AppDir + 'waterfall_' + Filename);
  Log('Spectrum and waterfall saved');
end;

procedure TForm1.Savepreset1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    SavePresetToFile(SaveDialog1.FileName);
end;

procedure TForm1.Spectrumgraphcolor1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then LevelColor := ColorDialog1.Color;
end;

procedure TForm1.Spectrummaxcolor1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then MaxColor := ColorDialog1.Color;
end;

procedure TForm1.Splitter1Moved(Sender: TObject);
begin
  DrawWF;
end;

procedure TForm1.AutoAxisClick(Sender: TObject);
begin
  ProcessVisualSettings;
end;

procedure TForm1.Chart1MouseEnter(Sender: TObject);
begin
  SPCursor := True;
end;

procedure TForm1.Chart1MouseLeave(Sender: TObject);
begin
  SPCursor := False;
  Chart1.Repaint;
end;

procedure TForm1.Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  tmpX, tmpY: Double;
begin
  Chart1.Series[0].GetCursorValues(tmpx, tmpy);
  Chart1.Hint := Chart1.Series[0].GetHorizAxis.LabelValue(tmpX) + ' Hz' + #13#10
    + Chart1.Series[0].GetVertAxis.LabelValue(tmpY) + ' dB';

  SPCursorX := X;
  SPCursorY := Y;
  DrawSP;
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

procedure TForm1.ProcessVisualSettings;
begin
  // Visibility of chart MaxPower
  if DrawMaxPower.Checked then
    Chart1.Series[1].Visible := True
  else
    Chart1.Series[1].Visible := False;

  // Automatic chart dB axis
  if AutoAxis.Checked then begin
    Chart1.LeftAxis.Automatic := True;
  end else begin
    Chart1.LeftAxis.Automatic := False;
    Chart1.LeftAxis.Minimum := iMinDb;
    Chart1.LeftAxis.Maximum := iMaxDb;
  end;

  // Visibility of chart peaks
  if MarkPeaks.Checked then
    Chart1.Series[2].Visible := True
  else
    Chart1.Series[2].Visible := False;

  // Chart axis visibility
  Chart1.LeftAxis.Visible := LeftAxis.Checked;
  Chart1.BottomAxis.Visible := BottomAxis.Checked;
end;

function TForm1.RoundFreq(var Freq: Double): Integer;
var
  mUnit: Char;
  IntFreq, LoFreq, HiFreq, Offset, Rounder: Int64;
begin
  if Length(StepSize.Text) < 1 then begin
    Result := 0;
    Exit;
  end;

  mUnit := StepSize.Text[Length(StepSize.Text)];
  Rounder := 1;
  case mUnit of
    'k', 'K': Rounder := StrToInt( LeftStr(StepSize.Text, Length(StepSize.Text)-1) ) * 1000;
    'm', 'M': Rounder := StrToInt( LeftStr(StepSize.Text, Length(StepSize.Text)-1) ) * 1000000;
  end;

  IntFreq := Round(Freq);
  Offset  := IntFreq mod Rounder;
  LoFreq  := IntFreq - Offset;
  HiFreq  := LoFreq + Rounder;

  if (IntFreq - LoFreq) <= (HiFreq - IntFreq) then
    Result := LoFreq
  else
    Result := HiFreq;
end;

procedure TForm1.ProcessChart;
var
  i: integer;
begin
  Chart1.Series[0].Clear;
  Chart1.Series[1].Clear;
  Chart1.Series[2].Clear;
  for i := 0 to High(Power) do begin
    Chart1.Series[0].AddXY(Freq[i], Power[i], '', LevelColor);
    Chart1.Series[1].AddXY(Freq[i], MaxPower[i], '', MaxColor);
    if Peak[i] then
      Chart1.Series[2].AddXY(Freq[i], Power[i], '', clGreen);
  end;
end;

function TForm1.LoadRtlPowerData(var Data: TStringList): integer;
var
  i: Integer;
  S, S2, DataString: String;
  SourceData: TStringList;
begin
  SourceData := TStringList.Create;
  try
    Data.Clear;
    DataString := '';

    // Loading rtl_power scan results
    SourceData.LoadFromFile(AppDir + 'scan.csv');

    for S in SourceData do begin
      // trim first unnecessary data
      S2 := Copy(S, Pos(',', S)+1, Length(S)-Pos(',', S));
      // cutting other unnecessary things before interesting data
      for i := 1 to 4 do
        S2 := Copy(S2, Pos(',', S2)+1, Length(S2)-Pos(',', S2));
      // joining new interesting data
      DataString := DataString + Trim(Copy(S2, Pos(',', S2)+1, Length(S2)-Pos(',', S2))) + ', ';
    end;
    DataString := Copy(DataString, 0, Length(DataString)-2);
  finally
    SourceData.Free;
  end;

  // Loading parsed lines as strings into Data
  Data.Delimiter := ',';
  Data.DelimitedText := DataString;

  Result := Data.Count - 1;
end;

function TForm1.PrepareCommandLine: String;
var
  CommandLine: String;
begin
  CommandLine := '-f ' + IntToStr(FromMHZ.Value) + ':'
                       + IntToStr(TillMHZ.Value) + ':'
                       + StepSize.Text;

  if not TunerAGC.Checked then
    CommandLine := CommandLine + ' -g ' + Gain.Text;

  if DirectSampling.Checked then
    CommandLine := CommandLine + ' -D';

  if EnablePeakHold.Checked then
    CommandLine := CommandLine + ' -P';

  if Crop0.Checked  then CommandLine := CommandLine + ' -c 0%';
  if Crop10.Checked then CommandLine := CommandLine + ' -c 10%';
  if Crop20.Checked then CommandLine := CommandLine + ' -c 20%';
  if Crop30.Checked then CommandLine := CommandLine + ' -c 30%';
  if Crop40.Checked then CommandLine := CommandLine + ' -c 40%';
  if Crop50.Checked then CommandLine := CommandLine + ' -c 50%';
  if Crop60.Checked then CommandLine := CommandLine + ' -c 60%';
  if Crop70.Checked then CommandLine := CommandLine + ' -c 70%';
  if Crop80.Checked then CommandLine := CommandLine + ' -c 80%';
  if Crop90.Checked then CommandLine := CommandLine + ' -c 90%';
  if Crop100.Checked then CommandLine := CommandLine + ' -c 99%';

  CommandLine := CommandLine + ' -p ' + IntToStr(PPM.Value);
  CommandLine := CommandLine + ' -d ' + IntToStr(ChooseDongle.Value);
  CommandLine := CommandLine + ' -1 -i 1s scan.csv';

  Result := CommandLine;
end;

procedure TForm1.InitArrays(var DataSize: integer);
var
  i: integer;
begin
  SetLength(Freq, DataSize + 1);
  SetLength(MaxPower, DataSize + 1);
  SetLength(Power, DataSize + 1);
  SetLength(Peak, DataSize + 1);
  if MaxPowerReset then begin
    MaxPowerReset := False;
    for i := 0 to DataSize do MaxPower[i] := -127.0;
  end;
end;

function CompareStringsAsIntegers(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := StrToInt(List[Index1]) - StrToInt(List[Index2]);
end;

procedure TForm1.CalculatePeaks;
var
  i, j, k, FrameSize: Integer;
  Flag: Boolean;
  min, max, SpectrumX, SpectrumStep: Double;
begin
  FrameSize := 10;

  SpectrumX    := FromMHZ.Value;
  SpectrumStep := (TillMHZ.Value - FromMHZ.Value) / High(Power);

  for i := 0 to High(Power) do begin
    Freq[i] := SpectrumX;

    Flag := True;
    min := 127;
    max := -127;
    for j := 0 to FrameSize do begin
      k := Round(i + j - FrameSize / 2);
      if (k <> i) and (k >= 0) and (k < High(Power)) then begin
        if (Power[k] > Power[i]) then begin
          Flag := False;
          break;
        end;
        if (Power[k] = Power[i]) and (i < k) then begin
          Flag := False;
          break;
        end;
        if (Power[k] > max) then max := Power[k];
        if (Power[k] < min) then min := Power[k];
      end;
    end;
    Peak[i] := Flag and (max-min >= 5);
    if (Peak[i]) then Frequencies.Add( IntToStr( RoundFreq( Freq[i] ) ) );

    SpectrumX := SpectrumX + SpectrumStep;
  end;

  Log('', Format('Step: %.3f Hz', [SpectrumStep]), 'FFT bins: ' + IntToStr(High(Power)));
end;

procedure TForm1.UpdateFrequencies;
begin
  if Frequencies.Count > 25000 then Frequencies.Clear;
  if not Form2.Visible then Exit;
  Frequencies.Sorted := False;
  Frequencies.CustomSort(CompareStringsAsIntegers);
  Form2.FMListBox.Items := Frequencies;
  Frequencies.Sorted := True;
end;

procedure TForm1.ParseRtlPowerData(var Data: TStringList; var DataSize: integer);
var
  i: integer;
begin
  // Succesfully parse data strings
  FormatSettings.DecimalSeparator := '.';

  for i := 0 to DataSize do begin
    if Data[i] = '-1.#J' then Data[i] := '-1.00';   // fix -1.#J rtl_power
    Power[i] := StrToFloat( Trim(Data[i]) );        // populate power
    if (MaxPower[i] < Power[i]) then
      MaxPower[i] := Power[i];                      // populate max power
  end;
end;

procedure TForm1.MainLoop;
var
  Data: TStringList;
  DataSize: Integer;
begin
while Processing do begin
  Inc(ScanCounter);
  Log(Format('Scanning %d-%d Hz', [FromMHZ.Value, TillMHZ.Value]));
  ExecAndWait(AppDir + 'rtl_power.exe', PrepareCommandLine, SW_HIDE);
  Data := TStringList.Create;
  try
    DataSize := LoadRtlPowerData(Data);
    InitArrays(DataSize);
    ParseRtlPowerData(Data, DataSize);
    AddLineToWaterFall;
    CalculatePeaks;
    ProcessChart;
    ProcessVisualSettings;
    UpdateFrequencies;
    DrawSP;
    DrawWF;
  finally
    Data.Free;
  end;
  Log('Ready...');
  Application.ProcessMessages;
end;
end;

procedure TForm1.OptionsButtonClick(Sender: TObject);
begin
  PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TForm1.PressResetMaxPowerLevel(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', 'k', 'm', 'K', 'M', #8]) then Key := #0;
  MaxPowerReset := True;
end;

procedure TForm1.ResetMaxPowerLevel(Sender: TObject);
begin
  MaxPowerReset := True;
end;

procedure TForm1.WaterFallMouseEnter(Sender: TObject);
begin
  WFCursor := True;
end;

procedure TForm1.WaterFallMouseLeave(Sender: TObject);
begin
  WFCursor := False;
  DrawWaterFallPicture;  // to remove red line
end;

procedure TForm1.WaterFallMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Freq: Double;
begin
  Freq := FromMHZ.Value + ( (TillMHZ.Value - FromMHZ.Value) / WaterFall.Width ) * X;
  WaterFall.Hint := Format('%.3f MHz', [Freq/1000000]);

  WFCursorX := X;
  WFCursorY := Y;
  DrawWF;
end;

procedure TForm1.DrawWF;
begin
  DrawWaterFallPicture;

  if WFCursor then begin
    WaterFall.Canvas.Pen.Color := clRed;
    WaterFall.Canvas.MoveTo(WFCursorX, 0);
    WaterFall.Canvas.LineTo(WFCursorX, WaterFall.Height);

    WaterFall.Canvas.Font.Color := clLime;
    WaterFall.Canvas.Brush.Style := bsClear;
    WaterFall.Canvas.TextOut(WFCursorX + 3, WFCursorY - 12, WaterFall.Hint);
  end;
end;

procedure TForm1.DrawSP;
begin
  Chart1.Repaint;

  if SPCursor then begin
    Chart1.Canvas.Pen.Color := clRed;
    Chart1.Canvas.MoveTo(SPCursorX, 0);
    Chart1.Canvas.LineTo(SPCursorX, Chart1.Height);

    Chart1.Canvas.Font.Color := clBlue;
    Chart1.Brush.Style := bsClear;
    Chart1.Canvas.TextOut(SPCursorX + 3, SPCursorY - 16, Chart1.Hint);
  end;
end;

procedure TForm1.WaterFallPaint(Sender: TObject);
begin
  DrawWF;  // on form resize etc
end;

procedure TForm1.Waterfallcolor1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
    WFColor := ColorDialog1.Color;
end;

end.
