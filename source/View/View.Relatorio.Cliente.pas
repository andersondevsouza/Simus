unit View.Relatorio.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, Datasnap.DBClient;

type
  TfrmRelCliente = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    dsRel: TDataSource;
    cdsRel: TClientDataSet;
    cdsRelCodigo: TIntegerField;
    cdsRelNome: TStringField;
    cdsRelCpf: TStringField;
    cdsRelDtNascimento: TDateField;
    cdsRelStatus: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCliente: TfrmRelCliente;

implementation

{$R *.dfm}

end.
