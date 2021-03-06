﻿unit uBackupRestore;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IBX.IBServices, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons,Vcl.FileCtrl, Vcl.ExtCtrls, uClasseBackup;

type
  TfrmBackup = class(TForm)
    pgControle: TPageControl;
    tsBackup: TTabSheet;
    tsRestore: TTabSheet;
    RestoreBanco: TIBRestoreService;
    BackupBanco: TIBBackupService;
    opDiretorio: TOpenDialog;
    Label1: TLabel;
    edtDirBanco: TEdit;
    btnDirBanco: TBitBtn;
    Label2: TLabel;
    edtDirBackup: TEdit;
    Label3: TLabel;
    edtNomeBanco: TEdit;
    btnBackup: TBitBtn;
    btnDirBackup: TBitBtn;
    Label4: TLabel;
    mmProgessoBackup: TMemo;
    mmProgressoRestore: TMemo;
    Label5: TLabel;
    Label6: TLabel;
    edtDirBacRestore: TEdit;
    edtDirRestore: TEdit;
    btnDirBacRestore: TBitBtn;
    btnDirRestore: TBitBtn;
    btnRestore: TBitBtn;
    Panel1: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    txtDataRestore: TLabel;
    txtHoraRestore: TLabel;

    procedure btnDirBancoClick(Sender: TObject);
    procedure btnBackupClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDirBackupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDirBacRestoreClick(Sender: TObject);
    procedure btnDirRestoreClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBackup: TfrmBackup;
  Bkp : TBackup;

implementation

{$R *.dfm}

uses uClasseException;

procedure TfrmBackup.btnBackupClick(Sender: TObject);
begin
  // Passa os paramentros para pode inicia o Backup
  Bkp.IniciaBackup( edtDirBanco.Text, edtDirBackup.Text, mmProgessoBackup, BackupBanco );
end;

procedure TfrmBackup.btnDirBackupClick(Sender: TObject);
begin
  // Seleciona a pasta aonde vai ser gerado o Restore
 edtDirBackup.Text := Bkp.SelectDir(' Selecione a pasta de Instalação ') + edtNomeBanco.Text;
end;

procedure TfrmBackup.btnDirBacRestoreClick(Sender: TObject);
begin
  //opDiretorio.InitialDir := ExtractFilePath(Application.ExeName + 'Backup\');
  if opDiretorio.Execute then begin
    edtDirBacRestore.Text := opDiretorio.FileName;
  end;
  edtDirRestore.Text := ExtractFilePath(ParamStr(0))+'Dados\Dados.fdb';
  btnDirRestore.Enabled := True;
  btnRestore.Enabled := True;
end;

procedure TfrmBackup.btnDirBancoClick(Sender: TObject);
begin
 //opDiretorio.InitialDir := ExtractFilePath(Application.ExeName + 'Dados\');
  if opDiretorio.Execute then begin
    edtDirBanco.Text := opDiretorio.FileName;
    edtNomeBanco.Text := 'Backup'+FormatDateTime('ddmmyy',date)+'.fbk';
    btnDirBackup.Enabled := True;
    edtDirBackup.Text := ExtractFilePath(Application.ExeName)+'Backup\'+edtNomeBanco.Text;
  end;
end;

procedure TfrmBackup.btnDirRestoreClick(Sender: TObject);
begin
  //opDiretorio.InitialDir := ExtractFilePath(Application.ExeName);
  edtDirRestore.Text := Bkp.SelectDir('Selecione a pasta de Instala��o')+'\Dados.fdb';
end;

procedure TfrmBackup.btnRestoreClick(Sender: TObject);
begin
  // Passa os paramentros para pode inicia o Restore
  Bkp.IniciaRestore( edtDirBacRestore.Text, edtDirRestore.Text, mmProgressoRestore, RestoreBanco );
end;

procedure TfrmBackup.FormCreate(Sender: TObject);
begin
  // Criar a pasta Backup se não existi
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+ 'Backup') then begin
    CreateDir(ExtractFilePath(Application.ExeName)+'Backup');
  end;
end;

procedure TfrmBackup.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TfrmBackup.FormShow(Sender: TObject);
begin
{    // Colocar a ultima data e hora no DBText
  txtData.Caption := Formatacao( 'Data', Bkp.UltimoBkp( 'BK',true ) );
  txtHora.Caption := Formatacao( 'Hora', Bkp.UltimoBkp( 'BK',False ) );
  txtDataRestore.Caption := Formatacao( 'Data', Bkp.UltimoBkp( 'RT',true ) );
  txtHoraRestore.Caption := Formatacao( 'Hora', Bkp.UltimoBkp( 'RT',False ) );
}
end;

end.
