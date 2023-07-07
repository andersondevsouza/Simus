unit Interfaces.Produto;

interface

uses
  DataSnap.DBClient;

type
  iProduto = interface
    function Codigo(AValue: Integer): iProduto; overload;
    function Codigo: Integer; overload;
    function Descricao(AValue: String): iProduto; overload;
    function Descricao: String; overload;
    function PrecoUnitario(AValue: String): iProduto; overload;
    function PrecoUnitario: String; overload;
    function Fornecedor(AValue: Integer): iProduto; overload;
    function Fornecedor: Integer; overload;
    function Status(AValue: String): iProduto; overload;
    function Status: String; overload;
    function Criar: iProduto;
    function Listar(AFilter: String;
      var AClientDataSet: TClientDataSet): iProduto;
    function Editar: iProduto;
    function Deletar: iProduto;
    function ListarFornecedores(
      var AClientDataSet: TClientDataSet): iProduto;
  end;

implementation

end.
