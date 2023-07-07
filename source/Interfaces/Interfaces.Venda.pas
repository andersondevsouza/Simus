unit Interfaces.Venda;

interface

uses
  DataSnap.DBClient;

type
  iVenda = interface
    function Codigo(AValue: Integer): iVenda; overload;
    function Codigo: Integer; overload;
    function Cliente(AValue: Integer): iVenda; overload;
    function Cliente: Integer; overload;
    function Data(AValue: TDateTime): iVenda; overload;
    function Data: TDateTime; overload;
    function Total(AValue: Double): iVenda; overload;
    function Total: Double; overload;
    function Status(AValue: String): iVenda; overload;
    function Status: String; Overload;
    function Itens(AClientDataSet: TClientDataSet): iVenda; overload;
    function Listar(AFilter: String;
      var AClientDataSet: TClientDataSet): iVenda;
    function ListarItens(var AClientDataSet: TClientDataSet): iVenda;
    function Criar: iVenda;
    function Editar: iVenda;
    function Deletar: iVenda;
    function GerarRelatorio(var AClientDataSet: TClientDataSet): iVenda;
  end;

implementation

end.
