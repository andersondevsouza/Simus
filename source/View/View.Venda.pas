unit View.Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, Data.DB, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  untUtils, Controller.Cliente, Controller.Produto, System.StrUtils,
  Vcl.ComCtrls;

type
  TfrmVenda = class(TForm)
    pgVenda: TPageControl;
    tsConsulta: TTabSheet;
    tsManutencao: TTabSheet;
    dsItens: TDataSource;
    cdsItens: TClientDataSet;
    cdsItensCodigo: TIntegerField;
    cdsItensDescricao: TStringField;
    cdsItensPrecoUnitario: TFloatField;
    cdsItensQuantidade: TFloatField;
    cdsItensTotal: TFloatField;
    dsCliente: TDataSource;
    cdsCliente: TClientDataSet;
    cdsClienteCodigo: TIntegerField;
    cdsClienteNome: TStringField;
    cdsClienteCpf: TStringField;
    cdsClienteDtNascimento: TDateField;
    cdsClienteStatus: TStringField;
    cdsProduto: TClientDataSet;
    cdsProdutoCodigo: TIntegerField;
    cdsProdutoDescricao: TStringField;
    cdsProdutoPrecoUnitario: TFloatField;
    cdsProdutoFornecedor: TIntegerField;
    cdsProdutoStatus: TStringField;
    dsProduto: TDataSource;
    pnVenda: TPanel;
    Label1: TLabel;
    dblcCliente: TDBLookupComboBox;
    edtCodCliente: TEdit;
    pnFinalizacao: TPanel;
    Label7: TLabel;
    Label2: TLabel;
    edtTotalVenda: TMaskEdit;
    btnSalvarOrcamento: TBitBtn;
    btnConcluirVenda: TBitBtn;
    pnAddItem: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dblcProduto: TDBLookupComboBox;
    edtCodProd: TEdit;
    edtVlrUnit: TMaskEdit;
    edtVlrTot: TMaskEdit;
    edtQtd: TMaskEdit;
    btnAdd: TBitBtn;
    dbgItens: TDBGrid;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    DBGrid2: TDBGrid;
    dsConsultaVenda: TDataSource;
    cdsConsultaVenda: TClientDataSet;
    dsConsultaItens: TDataSource;
    cdsConsultaItens: TClientDataSet;
    cdsConsultaVendaCodigo: TIntegerField;
    cdsConsultaVendaClienteId: TIntegerField;
    cdsConsultaVendaTotal: TFloatField;
    cdsConsultaVendaStatus: TStringField;
    cdsConsultaVendaClienteNome: TStringField;
    cdsConsultaVendaData: TDateField;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel4: TPanel;
    BitBtn4: TBitBtn;
    cdsConsultaItensCodigo: TIntegerField;
    cdsConsultaItensDescricao: TStringField;
    cdsConsultaItensQuantidade: TFloatField;
    cdsConsultaItensTotal: TFloatField;
    cdsConsultaItensPrecoUnitario: TFloatField;
    procedure btnConcluirVendaClick(Sender: TObject);
    procedure dblcClienteClick(Sender: TObject);
    procedure edtQtdKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddClick(Sender: TObject);
    procedure edtQtdExit(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdExit(Sender: TObject);
    procedure dblcProdutoExit(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tsManutencaoShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnSalvarOrcamentoClick(Sender: TObject);
    procedure dsConsultaVendaDataChange(Sender: TObject; Field: TField);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    FCodigo: Integer;
    FEdicao: Boolean;
    procedure CarregarClientes;
    procedure CarregarProdutos;
    procedure LimparVenda;
    procedure LimparItem;
    procedure PreencheTotalItem;
    procedure PreencheTotalVenda;
    procedure AdicionarItem;
    procedure DeletarItem;
    procedure GravarVenda;
    procedure GravarOrcamento;
    procedure IrParaConsulta;
    procedure IrParaManutencao;
    procedure ListarVendas;
    function ValidarCamposItem: Boolean;
    function CalcularTotalItem(AVlrUnit, AQtd: Double): Double;
    function CalcularTotalVenda: Double;
  public
    { Public declarations }
  end;

var
  frmVenda: TfrmVenda;

implementation

uses
  Controller.Venda;

{$R *.dfm}

procedure TfrmVenda.AdicionarItem;
begin
  var LTotal := StringReplace(edtVlrTot.Text, '.', '', [rfReplaceAll]);

  cdsItens.Append;
  cdsItensCodigo.AsInteger := StrToInt(edtCodProd.Text);
  cdsItensDescricao.AsString := dblcProduto.Text;
  cdsItensPrecoUnitario.AsFloat := StrToFloat(edtVlrUnit.Text);
  cdsItensQuantidade.AsFloat := StrToFloat(edtQtd.Text);
  cdsItensTotal.AsFloat := StrToFloat(LTotal);
  cdsItens.Post;
end;

procedure TfrmVenda.BitBtn1Click(Sender: TObject);
begin
  FCodigo := 0;
  FEdicao := False;
  IrParaManutencao;
end;

procedure TfrmVenda.BitBtn2Click(Sender: TObject);
begin
  if Copy(cdsConsultaVendaStatus.AsString,1,1) = 'E' then begin
    Application.MessageBox('Venda efetivada n�o pode ser alterada!', '', MB_OK+MB_ICONINFORMATION);
    Exit;
  end;

  IrParaManutencao;
  FCodigo := cdsConsultaVendaCodigo.AsInteger;
  FEdicao := True;
  edtCodCliente.Text := cdsConsultaVendaClienteId.AsString;
  dblcCliente.KeyValue := cdsConsultaVendaClienteId.AsInteger;
  if not cdsItens.Active then
    cdsItens.CreateDataSet;
  cdsItens.EmptyDataSet;
  cdsItens.CloneCursor(cdsConsultaItens, false, true);

  btnSalvarOrcamento.Enabled := True;
  if Copy(cdsConsultaVendaStatus.AsString,1,1) = 'E' then
    btnSalvarOrcamento.Enabled := False;
end;

procedure TfrmVenda.BitBtn3Click(Sender: TObject);
begin
  if Copy(cdsConsultaVendaStatus.AsString,1,1) = 'E' then begin
    Application.MessageBox('Venda efetivada n�o pode ser deletada!', '', MB_OK+MB_ICONINFORMATION);
    Exit;
  end;
    
  if Application.MessageBox('Deseja realmente deletar a venda selecionada? ',
    '', MB_YESNO+MB_ICONQUESTION) = IDNO then
    Exit;
  
  var LVenda := TControllerVenda.Create;
  try
    LVenda.Codigo := cdsConsultaVendaCodigo.AsInteger;
    LVenda.Deletar;
  finally
    LVenda.Free;
  end;   

  ListarVendas; 
end;

procedure TfrmVenda.BitBtn4Click(Sender: TObject);
begin
  if cdsItens.RecordCount > 0 then begin
    var LMensagem := Concat('ATEN��O: Deseja realmente cancelar? Existem ',
      'altera��es que n�o foram salvas!'
    );
    if Application.MessageBox(PChar(LMensagem), '', MB_YESNO+MB_ICONQUESTION) = IDNO then
      Exit;  
  end;

  IrParaConsulta;
end;

procedure TfrmVenda.btnAddClick(Sender: TObject);
begin
  if cdsItens.Locate('Codigo', dblcProduto.KeyValue, []) then begin
    Application.MessageBox('Produto j� inserido!', '', MB_OK+MB_ICONERROR);
    Exit;
  end;

  if not ValidarCamposItem then
    Exit;

  AdicionarItem;

  PreencheTotalVenda;

  LimparItem;
  edtCodProd.SetFocus;
end;

procedure TfrmVenda.btnConcluirVendaClick(Sender: TObject);
begin
  GravarVenda;

  LimparVenda; 

  Application.MessageBox('Venda salva com sucesso!', '', MB_OK+MB_ICONINFORMATION);

  IrParaConsulta;

  ListarVendas;
end;

procedure TfrmVenda.btnSalvarOrcamentoClick(Sender: TObject);
begin
  GravarOrcamento;

  LimparVenda;

  Application.MessageBox('Or�amento salvo com sucesso!', '', MB_OK+MB_ICONINFORMATION);

  IrParaConsulta;

  ListarVendas;
end;

function TfrmVenda.CalcularTotalItem(AVlrUnit, AQtd: Double): Double;
begin
  Result := AVlrUnit * AQtd;
end;

function TfrmVenda.CalcularTotalVenda: Double;
begin
  Result := 0;
  cdsItens.First;
  while not cdsItens.Eof do begin
    Result := Result + cdsItensTotal.AsFloat;
    cdsItens.Next;
  end;
end;

procedure TfrmVenda.CarregarClientes;
begin
  var LCliente := TControllerCliente.Create;
  try
    var LFilter := ' and status = ''A'' ';
    cdsCliente.CloneCursor(LCliente.Listar(LFilter), false, true);
  finally
    LCliente.Free;
  end;
end;

procedure TfrmVenda.CarregarProdutos;
begin
  var LProduto := TControllerProduto.Create;
  try
    var LFilter := ' and status = ''A'' ';
    cdsProduto.CloneCursor(LProduto.Listar(LFilter), false, true);
  finally
    LProduto.Free;
  end;
end;

procedure TfrmVenda.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DeletarItem;
end;

procedure TfrmVenda.dblcClienteClick(Sender: TObject);
begin
  if not TUtils.StrVazio(dblcCliente.Text) then
    edtCodCliente.Text := dblcCliente.KeyValue;
end;

procedure TfrmVenda.dblcProdutoExit(Sender: TObject);
begin
  edtCodProd.Text := dblcProduto.KeyValue;
  edtVlrUnit.Text := FloatToStrF(cdsProdutoPrecoUnitario.AsFloat, ffNumber,12,2);
  PreencheTotalItem;
end;

procedure TfrmVenda.DeletarItem;
begin
  if cdsItens.IsEmpty then
    Exit;
    
  if Application.MessageBox('Deseja realmente deletar o item selecionado? ',
    '', MB_YESNO+MB_ICONQUESTION) = IDNO then
    Exit;
  
  cdsItens.Delete;
  PreencheTotalVenda;
end;

procedure TfrmVenda.dsConsultaVendaDataChange(Sender: TObject; Field: TField);
begin
  var LVenda := TControllerVenda.Create;
  try
    LVenda.Codigo := cdsConsultaVendaCodigo.AsInteger;
    cdsConsultaItens.CloneCursor(LVenda.ListarItens, 
      false, true);
    cdsConsultaItens.First;
  finally
    LVenda.Free;
  end;
end;

procedure TfrmVenda.edtCodClienteExit(Sender: TObject);
begin
  dblcCliente.KeyValue := edtCodCliente.Text;
end;

procedure TfrmVenda.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if (key in ['0'..'9'] = false) then
    key := #0;
end;

procedure TfrmVenda.edtCodProdExit(Sender: TObject);
begin
  dblcProduto.KeyValue := edtCodProd.Text;
  edtCodProd.Text := dblcProduto.KeyValue;
  edtVlrUnit.Text := FloatToStrF(cdsProdutoPrecoUnitario.AsFloat, ffNumber,12,2);
  PreencheTotalItem;
end;

procedure TfrmVenda.edtQtdExit(Sender: TObject);
begin
  PreencheTotalItem;
end;

procedure TfrmVenda.edtQtdKeyPress(Sender: TObject; var Key: Char);
begin
  if (key in ['0'..'9', ','] = false) then
    key := #0;
end;

procedure TfrmVenda.FormCreate(Sender: TObject);
begin
  ListarVendas;
end;

procedure TfrmVenda.FormShow(Sender: TObject);
begin
  IrParaConsulta;
end;

procedure TfrmVenda.GravarOrcamento;
begin
  var LVenda := TControllerVenda.Create;
  try
    LVenda.Cliente := StrToInt(edtCodCliente.Text);
    LVenda.Data := Now;
    var LTotalVenda := StringReplace(edtTotalVenda.Text, '.', '', [rfReplaceAll]);
    LVenda.Total := StrToFloat(LTotalVenda);
    LVenda.Status := 'P';
    LVenda.Itens := cdsItens;
    if FEdicao then
      LVenda.Codigo := FCodigo;
    LVenda.Criar;
  finally
    LVenda.Free;
  end;
end;

procedure TfrmVenda.GravarVenda;
begin
  var LVenda := TControllerVenda.Create;
  try
    LVenda.Cliente := StrToInt(edtCodCliente.Text);
    LVenda.Data := Now;
    var LTotalVenda := StringReplace(edtTotalVenda.Text, '.', '', [rfReplaceAll]);
    LVenda.Total := StrToFloat(LTotalVenda);
    LVenda.Status := 'E';
    LVenda.Itens := cdsItens;
    if FEdicao then begin
      LVenda.Codigo := FCodigo;
      LVenda.Editar;
    end else
      LVenda.Criar;
  finally
    LVenda.Free;
  end;
end;

procedure TfrmVenda.IrParaConsulta;
begin
  tsConsulta.TabVisible := True;
  tsConsulta.Show;
  tsManutencao.TabVisible := False;
end;

procedure TfrmVenda.IrParaManutencao;
begin
  tsManutencao.TabVisible := True;
  tsManutencao.Show;
  tsConsulta.TabVisible := False;
end;

procedure TfrmVenda.LimparItem;
begin
  edtCodProd.Text := '0';
  dblcProduto.KeyValue := -1;
  edtVlrUnit.Text := '0,00';
  edtQtd.Text := '0';
  edtVlrTot.Text := '0,00';
end;

procedure TfrmVenda.LimparVenda;
begin
  edtCodCliente.Text := '0';
  dblcCliente.KeyValue := -1;
  edtTotalVenda.Text := '0,00';

  if not cdsItens.Active then
    cdsItens.CreateDataSet;
  cdsItens.EmptyDataSet;

  LimparItem;
end;

procedure TfrmVenda.ListarVendas;
begin
  var LVenda := TControllerVenda.Create;
  try
    cdsConsultaVenda.CloneCursor(LVenda.Listar(''), false, true);
    cdsConsultaVenda.First;
  finally
    LVenda.Free;
  end;
end;

procedure TfrmVenda.PreencheTotalItem;
begin
  edtVlrTot.Text := FloatToStrF(CalcularTotalItem(StrToFloat(edtVlrUnit.Text),
    StrToFloat(edtQtd.Text)), ffNumber, 12,2);
end;

procedure TfrmVenda.PreencheTotalVenda;
begin
  edtTotalVenda.Text := FloatToStrF(CalcularTotalVenda, ffNumber, 12,2);
end;

procedure TfrmVenda.tsManutencaoShow(Sender: TObject);
begin
  CarregarClientes;
  CarregarProdutos;
  LimparVenda;
end;

function TfrmVenda.ValidarCamposItem: Boolean;
begin
  Result := True;

  if TUtils.StrVazio(dblcProduto.Text) then
    Exit(False);

  if StrToFloat(edtVlrUnit.Text) = 0 then
    Exit(False);

  if StrToFloat(edtQtd.Text) = 0 then
    Exit(False);
end;

end.
