unit View.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Padrao.Cadastro, Data.DB,
  Datasnap.DBClient, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask, untUtils, Controller.Produto, System.StrUtils;

type
  TfrmCadastroProduto = class(TfrmPadraoCadastro)
    cdsConsulta: TClientDataSet;
    cdsConsultaCodigo: TIntegerField;
    cdsConsultaDescricao: TStringField;
    cdsConsultaPrecoUnitario: TFloatField;
    cdsConsultaFornecedor: TIntegerField;
    cdsConsultaStatus: TStringField;
    Label1: TLabel;
    edtNome: TDBEdit;
    Label2: TLabel;
    edtPreco: TDBEdit;
    cbStatus: TDBCheckBox;
    Label3: TLabel;
    dblcFornecedor: TDBLookupComboBox;
    dsFornecedor: TDataSource;
    cdsFornecedor: TClientDataSet;
    cdsFornecedorCodigo: TIntegerField;
    cdsFornecedorNomeFantasia: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
  private
    { Private declarations }
    FEdicao: Boolean;
    procedure Listar;
    procedure ListarFornecedor;
    function ValidarCampos: Boolean;
  public
    { Public declarations }
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

{$R *.dfm}

{ TfrmCadastroProduto }

procedure TfrmCadastroProduto.btnAdicionarClick(Sender: TObject);
begin
  FEdicao := False;
  edtNome.SetFocus;
  inherited;
  cdsConsultaPrecoUnitario.AsFloat := 0;
end;

procedure TfrmCadastroProduto.btnDeletarClick(Sender: TObject);
begin
  if Application.MessageBox('Atenção: Deseja realmente excluir este registro?',
    '', MB_YESNO+MB_ICONQUESTION) = IDNO then
    Exit;

  var LProduto := TControllerProduto.Create;
  try
    LProduto.Codigo := cdsConsultaCodigo.AsInteger;
    LProduto.Deletar;
  finally
    LProduto.Free;
  end;
  inherited;
  Listar;
end;

procedure TfrmCadastroProduto.btnEditarClick(Sender: TObject);
begin
  FEdicao := True;
  edtNome.SetFocus;
  inherited;

end;

procedure TfrmCadastroProduto.btnSalvarClick(Sender: TObject);
begin
  if not ValidarCampos then
    Exit;

  inherited;
  var LBookMark := cdsConsulta.GetBookmark;
  var LProduto := TControllerProduto.Create;
  try
    LProduto.Descricao := cdsConsultaDescricao.AsString;
    LProduto.PrecoUnitario := cdsConsultaPrecoUnitario.AsFloat;
    LProduto.Fornecedor := cdsConsultaFornecedor.AsInteger;
    LProduto.Status := ifthen(cdsConsultaStatus.AsString = 'Ativo', 'A', 'I');

    if FEdicao then begin
      LProduto.Codigo := cdsConsultaCodigo.AsInteger;
      LProduto.Editar;
    end else
      LProduto.Criar;
  finally
    LProduto.Free;
  end;

  Listar;

  cdsConsulta.GotoBookmark(LBookMark);
end;

procedure TfrmCadastroProduto.FormCreate(Sender: TObject);
begin
  inherited;
  Listar;
  ListarFornecedor;
end;

procedure TfrmCadastroProduto.Listar;
begin
  var LProduto := TControllerProduto.Create;
  try
    cdsConsulta.CloneCursor(LProduto.Listar(edtFiltro.Text), false, true);
  finally
    LProduto.Free;
  end;
end;

procedure TfrmCadastroProduto.ListarFornecedor;
begin
  var LProduto := TControllerProduto.Create;
  try
    cdsFornecedor.CloneCursor(LProduto.ListarFornecedor, false, true);
  finally
    LProduto.Free;
  end;
end;

function TfrmCadastroProduto.ValidarCampos: Boolean;
begin
  Result := True;

  if TUtils.StrVazio(edtNome.Text) then begin
    Application.MessageBox('Informe o nome do produto!', '', MB_OK+MB_ICONEXCLAMATION);
    edtNome.SetFocus;
    Exit(False);
  end;

  if cdsConsultaPrecoUnitario.AsFloat = 0 then begin
    Application.MessageBox('Informe o preço do produto!', '', MB_OK+MB_ICONEXCLAMATION);
    edtPreco.SetFocus;
    Exit(False);
  end;
end;

end.
