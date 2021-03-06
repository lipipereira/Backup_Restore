﻿unit uClasseBackup;

interface

uses
  Data.SqlExpr, Data.DB,System.classes, Vcl.DBGrids, Vcl.StdCtrls,
  IBX.IBServices;

Type
    TBackup = class
    public
      //Metodos
      function SelectDir(Title : string) : string;

      procedure IniciaBackup( DirBanco, DirBackup: String; Mm: TMemo;
                              BackupBanco: TIBBackupService );
      procedure IniciaRestore( DirBackup, DirRestore: String; Mm: TMemo;
                              RestoreBanco: TIBRestoreService );
end;

implementation

uses
  System.SysUtils, Vcl.FileCtrl, Vcl.Forms,
  Winapi.Windows, Vcl.Controls;

function TBackup.SelectDir(Title: string): string;
var
  Pasta : String;
begin
  SelectDirectory(Title, '', Pasta);
  if (Trim(Pasta) <> '') then
    if (Pasta[Length(Pasta)] <> '\') then
      Pasta := Pasta + '\';
  Result := Pasta;
end;

procedure TBackup.IniciaBackup(DirBanco, DirBackup: String; Mm: TMemo;
  BackupBanco: TIBBackupService);
begin
  if DirBanco = EmptyStr then
    Application.MessageBox(' Arquivo de Backup não informado. '+
                          ' Por favor informe o arquivo!!! ','Atenção',MB_OK)
  else
    try
      // muda o cursos do mouse
      Screen.Cursor := crHourGlass;
      with BackupBanco do
      begin
        Attach;
        LoginPrompt := False;
        // Passa o caminho do banco de dados
        DatabaseName := DirBanco;
        // Passa o caminho do local do backup
        BackupFile.Add( DirBackup );
        Active := True;
        Verbose := True;
        // inicia o backup
        ServiceStart;
        while not Eof do begin
          // mostra o andamento no TMemo
          Mm.Lines.Add(GetNextLine)
        end;
        Active := False;
      end;
    finally
      Screen.Cursor := crDefault;
      // informa se o processo ocorreu com sucesso
      Application.MessageBox(' Backup efetuado com sucesso!!! ','Confirmação ',MB_OK);
    end;
    Application.ProcessMessages;
end;

procedure TBackup.IniciaRestore(DirBackup, DirRestore: String; Mm: TMemo;
  RestoreBanco: TIBRestoreService);
begin
  try
    Screen.Cursor := crHourGlass;
    with RestoreBanco do
    begin
      Attach;
      Options := [Replace];
      // Passa o caminho do backup
      BackupFile.Add( DirBackup );
      // Passa o caminho aonde vai ser gerado o Banco.FDB
      DatabaseName.Add( DirRestore );
      Verbose := True;
      Active := True;
      // Inicia a restauração
      ServiceStart;
      while not Eof do begin
        // mostra o andamento no TMemo
        Mm.Lines.Add(GetNextLine)
      end;
      Active := False;
    end;
  finally
    Application.MessageBox(' Restauração efetuado com sucesso ','Confirmação ',MB_OK);
    Screen.Cursor := crDefault;
  end;
  Application.ProcessMessages;
end;

end.
