unit View.Padrao.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.StdCtrls;

type
  TfrmPadraoCadastro = class(TForm)
    dbgConsulta: TDBGrid;
    ds: TDataSource;
    pnBotoes: TPanel;
    btnDeletar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnAdicionar: TSpeedButton;
    pnFiltro: TPanel;
    pnCadastro: TPanel;
    edtFiltro: TEdit;
    lblFiltro: TLabel;
    btnSalvar: TSpeedButton;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure dsDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPadraoCadastro: TfrmPadraoCadastro;

implementation

{$R *.dfm}

procedure TfrmPadraoCadastro.btnAdicionarClick(Sender: TObject);
begin
  ds.DataSet.Insert;
end;

procedure TfrmPadraoCadastro.btnCancelarClick(Sender: TObject);
begin
  ds.DataSet.Cancel;
end;

procedure TfrmPadraoCadastro.btnDeletarClick(Sender: TObject);
begin
  ds.DataSet.Delete;
end;

procedure TfrmPadraoCadastro.btnEditarClick(Sender: TObject);
begin
  ds.DataSet.Edit;
end;

procedure TfrmPadraoCadastro.btnSalvarClick(Sender: TObject);
begin
  ds.DataSet.Post;
end;

procedure TfrmPadraoCadastro.dsDataChange(Sender: TObject; Field: TField);
begin
  btnAdicionar.Enabled := ds.State = dsBrowse;
  btnCancelar.Enabled := ds.State in [dsEdit, dsInsert];
  btnEditar.Enabled := ds.State = dsBrowse;
  btnDeletar.Enabled := ds.State = dsBrowse;
  btnSalvar.Enabled := ds.State in [dsEdit, dsInsert];
end;

end.
