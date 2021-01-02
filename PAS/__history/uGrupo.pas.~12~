unit uGrupo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmGrupo = class(TForm)
    DBGrid1: TDBGrid;
    btnInserir: TBitBtn;
    btnAlterar: TBitBtn;
    procedure btnInserirClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGrupo: TfrmGrupo;

implementation

{$R *.dfm}

uses uLibrary, uBancoDados, uCadastroGrupo, uAlterarGrupo;

procedure TfrmGrupo.btnAlterarClick(Sender: TObject);
begin
  // Criar form alterar Grupo
  CriarForm(TfrmAlterGrupo,frmAlterGrupo);
end;

procedure TfrmGrupo.btnInserirClick(Sender: TObject);
begin
  // Criar form de Cadastro Grupo
  CriarForm(TfrmCadGrupo,frmCadGrupo);
end;

procedure TfrmGrupo.DBGrid1DblClick(Sender: TObject);
begin
  // Criar form alterar Grupo al click duas vezez
  CriarForm(TfrmAlterGrupo,frmAlterGrupo);
end;

procedure TfrmGrupo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

end.
