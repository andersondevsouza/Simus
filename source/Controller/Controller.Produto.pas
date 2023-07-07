unit Controller.Produto;

interface

uses
  Model.Produto, DataSnap.DBClient, System.SysUtils;

type
  TControllerProduto = class
    private
      FCodigo: Integer;
      FDescricao: String;
      FPrecoUnitario: Double;
      FFornecedor: Integer;
      FStatus: String;
      FModelProduto: TModelProduto;
      constructor Create;
    public
      destructor Destroy; override;
      property Codigo: Integer read FCodigo write FCodigo;
      property Descricao: String read FDescricao write FDescricao;
      property PrecoUnitario: Double read FPrecoUnitario write FPrecoUnitario;
      property Fornecedor: Integer read FFornecedor write FFornecedor;
      property Status: String read FStatus write FStatus;

      function Criar: integer;
      procedure Editar;
      procedure Deletar;
      function Listar(AFilter: String): TClientDataSet;
      function ListarFornecedor: TClientDataSet;
  end;

implementation

{ TControllerProduto }

constructor TControllerProduto.Create;
begin

end;

function TControllerProduto.Criar: integer;
begin
  var LPrecoUnitario := StringReplace(FloatToStrF(PrecoUnitario, ffNumber, 10,2), ',', '.', [rfReplaceAll]);
  var LModelProduto := TModelProduto.New
    .Descricao(Descricao)
    .PrecoUnitario(LPrecoUnitario)
    .Fornecedor(Fornecedor)
    .Status(Status)
    .Criar;
end;

procedure TControllerProduto.Deletar;
begin
  var LModelProduto := TModelProduto.New
    .Codigo(Codigo)
    .Deletar;
end;

destructor TControllerProduto.Destroy;
begin

  inherited;
end;

procedure TControllerProduto.Editar;
begin
  var LPrecoUnitario := StringReplace(FloatToStrF(PrecoUnitario, ffNumber, 10,2), ',', '.', [rfReplaceAll]);
  var LModelProduto := TModelProduto.New
    .Codigo(Codigo)
    .Descricao(Descricao)
    .PrecoUnitario(LPrecoUnitario)
    .Fornecedor(Fornecedor)
    .Status(Status)
    .Editar;
end;

function TControllerProduto.Listar(AFilter: String): TClientDataSet;
begin
  var LModelProduto := TModelProduto.New
    .Listar(AFilter, Result);
end;

function TControllerProduto.ListarFornecedor: TClientDataSet;
begin
  var LModelProduto := TModelProduto.New
    .ListarFornecedores(Result);
end;

end.
