unit Interfaces.Cliente;

interface

uses
  DataSnap.DBClient;

type
  iCliente = interface
    function Codigo(AValue: Integer): iCliente; overload;
    function Codigo: Integer; overload;
    function Nome(AValue: String): iCliente; overload;
    function Nome: String; overload;
    function Cpf(AValue: String): iCliente; overload;
    function Cpf: String; overload;
    function DtNascimento(AValue: TDate): iCliente; overload;
    function DtNascimento: TDate; overload;
    function Status(AValue: String): iCliente; overload;
    function Status: String; overload;
    function Criar: iCliente;
    function Listar(AFilter: String;
      var AClientDataSet: TClientDataSet): iCliente;
    function Editar: iCliente;
    function Deletar: iCliente;
    function ValidarCpf(var AValue: Boolean): iCliente;
  end;

implementation

end.
