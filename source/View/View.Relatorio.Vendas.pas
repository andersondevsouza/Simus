unit View.Relatorio.Vendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, Datasnap.DBClient,
  untDm, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmRelVendas = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLDraw2: TRLDraw;
    RLLabel1: TRLLabel;
    cdsRel: TClientDataSet;
    dsRel: TDataSource;
    cdsRelCodigoVenda: TIntegerField;
    cdsRelData: TDateField;
    cdsRelProdutoId: TIntegerField;
    cdsRelDescricao: TStringField;
    cdsRelUnitario: TFloatField;
    cdsRelQuantidade: TFloatField;
    cdsRelTotal: TFloatField;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLLabel2: TRLLabel;
    RLDBText1: TRLDBText;
    RLDraw1: TRLDraw;
    RLDraw3: TRLDraw;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDraw4: TRLDraw;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelVendas: TfrmRelVendas;

implementation

{$R *.dfm}

end.
