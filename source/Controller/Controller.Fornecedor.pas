unit Controller.Fornecedor;

interface

uses
  Model.Fornecedor, DataSnap.DBClient;

type
  TControllerFornecedor = class
    private
      FCodigo: Integer;
      FNomeFantasia: String;
      FRazaoSocial: String;
      FCnpj: String;
      FStatus: String;
      FModelCliente: TModelFornecedor;
      constructor Create;
    public
      destructor Destroy; override;
      property Codigo: Integer read FCodigo write FCodigo;
      property NomeFantasia: String read FNomeFantasia write FNomeFantasia;
      property RazaoSocial: String read FRazaoSocial write FRazaoSocial;
      property Cnpj: String read FCnpj write FCnpj;
      property Status: String read FStatus write FStatus;

      function Criar: integer;
      procedure Editar;
      procedure Deletar;
      function Listar(AFilter: String): TClientDataSet;
      function ValidarCnpj: Boolean;
      function ValidarInativacaoFornecedor: Boolean;
  end;

implementation

{ TControllerFornecedor }

constructor TControllerFornecedor.Create;
begin
end;

function TControllerFornecedor.Criar: Integer;
begin
  var LModelFornecedor := TModelFornecedor.New
    .NomeFantasia(NomeFantasia)
    .RazaoSocial(RazaoSocial)
    .Cnpj(Cnpj)
    .Status(Status)
    .Criar;
end;

procedure TControllerFornecedor.Deletar;
begin
  var LModelFornecedor := TModelFornecedor.New
    .Codigo(Codigo)
    .Deletar;
end;

destructor TControllerFornecedor.Destroy;
begin
  inherited;
end;

procedure TControllerFornecedor.Editar;
begin

  var LModelFornecedor := TModelFornecedor.New
    .NomeFantasia(NomeFantasia)
    .RazaoSocial(RazaoSocial)
    .Cnpj(Cnpj)
    .Status(Status)
    .Editar;
end;

function TControllerFornecedor.Listar(AFilter: String): TClientDataSet;
begin
  var LModelFornecedor := TModelFornecedor.New
    .Listar(AFilter, Result);
end;

function TControllerFornecedor.ValidarCnpj: Boolean;
begin
  var LModelFornecedor := TModelFornecedor.New
    .Cnpj(cnpj)
    .ValidarCnpj(Result);
end;

function TControllerFornecedor.ValidarInativacaoFornecedor: Boolean;
begin
  var LModelFornecedor := TModelFornecedor.New
    .Codigo(Codigo)
    .ValidarInativacaoFornecedor(Result);
end;

end.
