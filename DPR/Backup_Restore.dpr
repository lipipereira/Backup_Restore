program Backup_Restore;

uses
  Vcl.Forms,
  uBackupRestore in '..\PAS\uBackupRestore.pas' {frmBackup},
  uClasseBackup in '..\PAS\Classes\uClasseBackup.pas',
  uClasseException in '..\PAS\Classes\uClasseException.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmBackup, frmBackup);
  Application.Run;
end.
