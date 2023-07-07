unit View.ChamaRleatorio.Vendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Data.DB, Datasnap.DBClient, View.Relatorio.Vendas, Controller.Venda,
  Controller.Cliente;

type
  TfrmChamaRelVendas = class(TForm)
    Label1: TLabel;
    dblcCliente: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    cdsCliente: TClientDataSet;
    cdsClienteCodigo: TIntegerField;
    cdsClienteNome: TStringField;
    cdsClienteCpf: TStringField;
    cdsClienteDtNascimento: TDateField;
    cdsClienteStatus: TStringField;
    ds: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChamaRelVendas: TfrmChamaRelVendas;

implementation

{$R *.dfm}

procedure TfrmChamaRelVendas.BitBtn1Click(Sender: TObject);
begin
  frmRelVendas := TfrmRelVendas.Create(nil);
  var LVenda := TControllerVenda.Create;
  try
    LVenda.Cliente := dblcCliente.KeyValue;
    frmRelVendas.cdsRel.CloneCursor(LVenda.GerarRelatorio, false, true);
    if frmRelVendas.cdsRel.RecordCount > 0 then
      frmRelVendas.RLReport1.Preview()
    else
      Application.MessageBox('Não há registros para serem visualizados!', '', MB_OK+MB_ICONEXCLAMATION);
  finally
    LVenda.Free;
    frmRelVendas.Free;
  end;
end;

procedure TfrmChamaRelVendas.FormShow(Sender: TObject);
begin
  var LCliente := TControllerCliente.Create;
  try
    cdsCliente.CloneCursor(LCliente.Listar(''), false, true);
  finally
    LCliente.Free;
  end;
end;

end.
