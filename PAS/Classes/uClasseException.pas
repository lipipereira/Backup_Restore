unit uClasseException;

interface

uses
  System.SysUtils, Vcl.Forms;

type
  TCapturaExcecoes = class
  private
  LogFile : String;
   // function ObterNomeUsuario: string;
   // function ObterVersaoWindows: string;
    //procedure GravarImagemFormulario(const NomeArquivo: string; Formulario: TForm);
  public
    constructor Create;
    procedure CapturarExcecao(Sender: TObject; E: Exception);
  end;

implementation

uses
  Winapi.Windows, System.UITypes,
  Vcl.Dialogs, Vcl.Graphics, Vcl.Imaging.jpeg, Vcl.ClipBrd,
  Vcl.ComCtrls;

{ TCapturaExcecoes }

constructor TCapturaExcecoes.Create;
begin
  LogFile := ChangeFileExt('LogErros','.log');
  Application.OnException := CapturarExcecao;
end;

procedure TCapturaExcecoes.CapturarExcecao(Sender: TObject; E: Exception);
var
  ArquivoLog: TextFile;
  StringBuilder: TStringBuilder;
  DataHora: string;
begin
  AssignFile(ArquivoLog, LogFile);

  // Se o arquivo existir, abre para edição,
  // Caso contrário, cria o arquivo
  if FileExists(LogFile) then
    Append(ArquivoLog)
  else
    ReWrite(ArquivoLog);

  DataHora := FormatDateTime('dd-mm-yyyy_hh-nn-ss', Now);
  WriteLn(ArquivoLog, 'Data/Hora.......: ' + DateTimeToStr(Now));
  WriteLn(ArquivoLog, 'Mensagem........: ' + E.Message);
  WriteLn(ArquivoLog, 'Classe Exceção..: ' + E.ClassName);
  WriteLn(ArquivoLog, 'Formulário......: ' + Screen.ActiveForm.Name);
  WriteLn(ArquivoLog, 'Unit............: ' + Sender.UnitName);
  WriteLn(ArquivoLog, 'Controle Visual.: ' + Screen.ActiveControl.Name);
  //WriteLn(ArquivoLog, 'Usuario.........: ' + ObterNomeUsuario);
  //WriteLn(ArquivoLog, 'Versão Windows..: ' + ObterVersaoWindows);
  WriteLn(ArquivoLog, StringOfChar('-', 70));

  // Fecha o arquivo
  CloseFile(ArquivoLog);

  //GravarImagemFormulario(DataHora, Screen.ActiveForm);

  // * Código para que a exceção seja exibida para o usuário *
  StringBuilder := TStringBuilder.Create;
  try
    // Exibe a mensagem para o usuário
    StringBuilder.AppendLine(E.Message);
    {StringBuilder.AppendLine(' Ocorreu um erro na aplicação. ')
      .AppendLine(' Entre em contato com o desenvolvedor ')
      .AppendLine(EmptyStr)
      .AppendLine(' Descrição técnica: ')
      .AppendLine(E.Message);
    }
    MessageDlg(StringBuilder.ToString, mtWarning, [mbOK], 0);
  finally
    StringBuilder.Free;
  end;
end;

var
  TratarExcept : TCapturaExcecoes;
initialization
  TratarExcept := TCapturaExcecoes.create;
Finalization
  TratarExcept.free;
    {
procedure TCapturaExcecoes.GravarImagemFormulario(const NomeArquivo: string; Formulario: TForm);
var
  Bitmap: TBitmap;
  JPEG: TJpegImage;
begin
  Bitmap := TBitmap.Create;
  JPEG := TJpegImage.Create;
  try
    Bitmap.Assign(Formulario.GetFormImage);
    JPEG.Assign(Bitmap);
    JPEG.SaveToFile(Format('%s\%s.jpg', [GetCurrentDir, NomeArquivo]));
  finally
    JPEG.Free;
    Bitmap.Free;
  end;
end;
   }
 {
function TCapturaExcecoes.ObterNomeUsuario: string;
var
  Size: DWord;
begin
  // retorna o login do usuário do sistema operacional
  Size := 1024;
  SetLength(result, Size);
  GetUserName(PChar(result), Size);
  SetLength(result, Size - 1);
end;

function TCapturaExcecoes.ObterVersaoWindows: string;
begin
  case System.SysUtils.Win32MajorVersion of
    5:
      case System.SysUtils.Win32MinorVersion of
        1: result := 'Windows XP';
      end;
    6:
      case System.SysUtils.Win32MinorVersion of
        0: result := 'Windows Vista';
        1: result := 'Windows 7';
        2: result := 'Windows 8';
        3: result := 'Windows 8.1';
      end;
    10:
      case System.SysUtils.Win32MinorVersion of
        0: result := 'Windows 10';
      end;
  end;
end;
   }
end.

