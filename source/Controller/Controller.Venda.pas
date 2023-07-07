unit Controller.Venda;

interface

uses
  Model.Venda, DataSnap.DBClient, System.SysUtils;

type
  TControllerVenda = class
    private
      FCodigo: Integer;
      FCliente: Integer;
      FData: TDateTime;
      FTotal: Double;
      FStatus: String;
      FItens: TClientDataSet;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Cliente: Integer read FCliente write FCliente;
      property Data: TDateTime read FData write FData;
      property Total: Double read FTotal write FTotal;
      property Status: String read FStatus write FStatus;
      property Itens: TClientDataSet read FItens write FItens;

      function Criar: integer;
      procedure Editar;
      procedure Deletar;
      function Listar(AFilter: String): TClientDataSet;
      function ListarItens: TClientDataSet;
      function ValidarCpf: Boolean;
      function GerarRelatorio: TClientDataSet;
  end;

implementation

{ TControllerVenda }

function TControllerVenda.Criar: integer;
begin
  var LVenda := TModelVenda.New
    .Cliente(Cliente)
    .Data(Data)
    .Total(Total)
    .Status(Status)
    .Itens(Itens)
    .Criar;
end;

procedure TControllerVenda.Deletar;
begin
  var LVenda := TModelVenda.New
    .Codigo(Codigo)
    .Deletar;
end;

procedure TControllerVenda.Editar;
begin
  var LVenda := TModelVenda.New
    .Codigo(Codigo)
    .Cliente(Cliente)
    .Total(Total)
    .Status(Status)
    .Itens(Itens)
    .Editar;
end;

function TControllerVenda.GerarRelatorio: TClientDataSet;
begin
  var LVenda := TModelVenda.New
    .Cliente(Cliente)
    .GerarRelatorio(Result);
end;

function TControllerVenda.Listar(AFilter: String): TClientDataSet;
begin
  var LVenda := TModelVenda.New
    .Listar(AFilter, Result);
end;

function TControllerVenda.ListarItens: TClientDataSet;
begin
  var LVenda := TModelVenda.New
    .Codigo(Codigo)
    .ListarItens(Result);
end;

function TControllerVenda.ValidarCpf: Boolean;
begin

end;

end.
