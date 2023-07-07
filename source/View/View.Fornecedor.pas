unit View.Fornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Padrao.Cadastro, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, untUtils,
  Controller.Fornecedor, Vcl.DBCtrls, Vcl.Mask, System.StrUtils;

type
  TfrmCadastroFornecedor = class(TfrmPadraoCadastro)
    cdsConsulta: TClientDataSet;
    cdsConsultaCodigo: TIntegerField;
    cdsConsultaNomeFantasia: TStringField;
    cdsConsultaRazaoSocial: TStringField;
    cdsConsultaCnpj: TStringField;
    cdsConsultaStatus: TStringField;
    Label1: TLabel;
    edtNomeFantasia: TDBEdit;
    Label2: TLabel;
    edtCnpj: TDBEdit;
    cbStatus: TDBCheckBox;
    edtRazaoSocial: TDBEdit;
    Label3: TLabel;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFiltroChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FEdicao: Boolean;
    procedure Listar;
    function ValidarCampos: Boolean;
  end;

var
  frmCadastroFornecedor: TfrmCadastroFornecedor;

implementation

{$R *.dfm}

{ TfrmCadastroFornecedor }

procedure TfrmCadastroFornecedor.btnAdicionarClick(Sender: TObject);
begin
  FEdicao := False;
  edtNomeFantasia.SetFocus;
  inherited;

end;

procedure TfrmCadastroFornecedor.btnDeletarClick(Sender: TObject);
begin
  if Application.MessageBox('Aten��o: Deseja realmente excluir este registro?',
    '', MB_YESNO+MB_ICONQUESTION) = IDNO then
    Exit;

  var LFornecedor := TControllerFornecedor.Create;
  try
    LFornecedor.Codigo := cdsConsultaCodigo.AsInteger;
    LFornecedor.Deletar;
  finally
    LFornecedor.Free;
  end;
  inherited;

end;

procedure TfrmCadastroFornecedor.btnEditarClick(Sender: TObject);
begin
  FEdicao := True;
  edtNomeFantasia.SetFocus;
  inherited;

end;

procedure TfrmCadastroFornecedor.btnSalvarClick(Sender: TObject);
begin
  if not ValidarCampos then
    Exit;

  inherited;
  var LBookMark := cdsConsulta.GetBookmark;
  var LFornecedor := TControllerFornecedor.Create;
  try
    LFornecedor.NomeFantasia := cdsConsultaNomeFantasia.AsString;
    LFornecedor.RazaoSocial := cdsConsultaRazaoSocial.AsString;
    LFornecedor.Cnpj := cdsConsultaCnpj.AsString;
    LFornecedor.Status := ifthen(cdsConsultaStatus.AsString = 'Ativo', 'A', 'I');

    if FEdicao then begin
      LFornecedor.Codigo := cdsConsultaCodigo.AsInteger;
      LFornecedor.Editar;
    end else
      LFornecedor.Criar;
  finally
    LFornecedor.Free;
  end;

  Listar;

  cdsConsulta.GotoBookmark(LBookMark);
end;

procedure TfrmCadastroFornecedor.edtFiltroChange(Sender: TObject);
begin
  inherited;
  var LFilter := Concat(
    'nomefantasia like(''%'+edtFiltro.Text+'%'') ',
    'or ',
    'razaosocial like(''%'+edtFiltro.Text+'%'') ',
    'or ',
    'cnpj like(''%'+edtFiltro.Text+'%'') '
  );
  cdsConsulta.Filtered := False;
  cdsConsulta.Filter := LFilter;
  cdsConsulta.Filtered := True;
end;

procedure TfrmCadastroFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  Listar;
end;

procedure TfrmCadastroFornecedor.Listar;
begin
  var LFornecedor := TControllerFornecedor.Create;
  try
    cdsConsulta.CloneCursor(LFornecedor.Listar(edtFiltro.Text), false, true);
  finally
    LFornecedor.Free;
  end;
end;

function TfrmCadastroFornecedor.ValidarCampos: Boolean;
begin
  Result := True;

  if TUtils.StrVazio(edtNomeFantasia.Text) then begin
    Application.MessageBox('Informe o nome fantasia do fornecedor!', '', MB_OK+MB_ICONEXCLAMATION);
    edtNomeFantasia.SetFocus;
    Exit(False);
  end;

  if TUtils.StrVazio(edtRazaoSocial.Text) then begin
    Application.MessageBox('Informe a raz�o social do fornecedor!', '', MB_OK+MB_ICONEXCLAMATION);
    edtRazaoSocial.SetFocus;
    Exit(False);
  end;

  if TUtils.StrVazio(edtCnpj.Text) then begin
    Application.MessageBox('Informe o cnpj do fornecedor!', '', MB_OK+MB_ICONEXCLAMATION);
    edtCnpj.SetFocus;
    Exit(False);
  end;

  var LFornecedor := TControllerFornecedor.Create;
  try
    LFornecedor.Cnpj := edtCnpj.Text;
    if ((LFornecedor.ValidarCnpj) and (not FEdicao)) then begin
      Application.MessageBox('Cnpj j� cadastrado!', '', MB_OK+MB_ICONEXCLAMATION);
      edtCnpj.SetFocus;
      Exit(False);
    end;

    if FEdicao then begin
      LFornecedor.Codigo := cdsConsultaCodigo.AsInteger;
      if not LFornecedor.ValidarInativacaoFornecedor then begin
        var LMensagem := Concat(
          'Este fornecedor n�o pode ser inativado ',
          'pois o mesmo est� relacionado a um ou mais produtos. Verifique! '
        );
        Application.MessageBox(PChar(LMensagem), '', MB_OK+MB_ICONEXCLAMATION);
        Exit(False);
      end;
    end;
  finally
    LFornecedor.Free;
  end;
end;

end.
