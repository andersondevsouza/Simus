unit View.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Padrao.Cadastro, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask,
  Datasnap.DBClient, Vcl.Buttons, Controller.Cliente, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.WinXCtrls,System.StrUtils,
  untUtils;

type
  TfrmCadastroCliente = class(TfrmPadraoCadastro)
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    cdsConsulta: TClientDataSet;
    cdsConsultaCodigo: TIntegerField;
    cdsConsultaNome: TStringField;
    cdsConsultaCpf: TStringField;
    cdsConsultaDtNascimento: TDateField;
    Label1: TLabel;
    edtNome: TDBEdit;
    Label2: TLabel;
    edtCpf: TDBEdit;
    Label3: TLabel;
    edtDtNascimento: TDBEdit;
    cdsConsultaStatus: TStringField;
    cbStatus: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure edtFiltroChange(Sender: TObject);
  private
    { Private declarations }
    FEdicao: Boolean;
    procedure Listar;
    function ValidarCampos: Boolean;
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}

procedure TfrmCadastroCliente.Listar;
begin
  var LCliente := TControllerCliente.Create;
  try
    cdsConsulta.CloneCursor(LCliente.Listar(edtFiltro.Text), false, true);
  finally
    LCliente.Free;
  end;
end;

function TfrmCadastroCliente.ValidarCampos: Boolean;
begin
  Result := True;

  if TUtils.StrVazio(edtNome.Text) then begin
    Application.MessageBox('Informe o nome do cliente!', '', MB_OK+MB_ICONEXCLAMATION);
    edtNome.SetFocus;
    Exit(False);
  end;

  if TUtils.StrVazio(edtCpf.Text) then begin
    Application.MessageBox('Informe o cpf do cliente!', '', MB_OK+MB_ICONEXCLAMATION);
    edtCpf.SetFocus;
    Exit(False);
  end;

  if FEdicao then
    Exit(True);

  var LCliente := TControllerCliente.Create;
  try
    LCliente.Cpf := edtCpf.Text;
    if LCliente.ValidarCpf then begin
      Application.MessageBox('Cpf j� cadastrado!', '', MB_OK+MB_ICONEXCLAMATION);
      edtCpf.SetFocus;
      Exit(False);
    end;
  finally
    LCliente.Free;
  end;
end;

procedure TfrmCadastroCliente.btnAdicionarClick(Sender: TObject);
begin
  FEdicao := False;
  edtNome.SetFocus;
  inherited;
end;

procedure TfrmCadastroCliente.btnDeletarClick(Sender: TObject);
begin
  if Application.MessageBox('Aten��o: Deseja realmente excluir este registro?',
    '', MB_YESNO+MB_ICONQUESTION) = IDNO then
    Exit;

  var LCliente := TControllerCliente.Create;
  try
    LCliente.Codigo := cdsConsultaCodigo.AsInteger;
    LCliente.Deletar;
  finally
    LCliente.Free;
  end;
  inherited;
  Listar;
end;

procedure TfrmCadastroCliente.btnEditarClick(Sender: TObject);
begin
  FEdicao := True;
  edtNome.SetFocus;
  inherited;
end;

procedure TfrmCadastroCliente.btnSalvarClick(Sender: TObject);
begin
  if not ValidarCampos then
    Exit;

  inherited;
  var LBookMark := cdsConsulta.GetBookmark;
  var LCliente := TControllerCliente.Create;
  try
    LCliente.Nome := cdsConsultaNome.AsString;
    LCliente.Cpf := cdsConsultaCpf.AsString;
    LCliente.DtNascimento := cdsConsultaDtNascimento.AsDateTime;
    LCliente.Status := ifthen(cdsConsultaStatus.AsString = 'Ativo', 'A', 'I');

    if FEdicao then begin
      LCliente.Codigo := cdsConsultaCodigo.AsInteger;
      LCliente.Editar;
    end else
      LCliente.Criar;
  finally
    LCliente.Free;
  end;

  Listar;

  cdsConsulta.GotoBookmark(LBookMark);
end;

procedure TfrmCadastroCliente.edtFiltroChange(Sender: TObject);
begin
  inherited;
  var LFilter := Concat(
    'nome like(''%'+edtFiltro.Text+'%'') ',
    'or ',
    'cpf like(''%'+edtFiltro.Text+'%'') '
  );
  cdsConsulta.Filtered := False;
  cdsConsulta.Filter := LFilter;
  cdsConsulta.Filtered := True;
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  inherited;
  Listar;
end;

end.
