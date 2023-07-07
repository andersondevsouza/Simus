unit Model.Venda;

interface

uses
  Interfaces.Venda, Datasnap.DBClient, Data.DB, untUtils, System.StrUtils,
  System.SysUtils, untDm, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TModelVenda = class(TInterfacedObject, iVenda)
    private
      FCodigo: Integer;
      FCliente: Integer;
      FData: TDateTime;
      FTotal: Double;
      FStatus: String;
      FItens: TClientDataSet;
      constructor Create;
      procedure SalvarVenda(AEdicao: Boolean);
      procedure SalvarItens(AVendaId: Integer; AEdicao: Boolean);
      procedure DeletarVenda;
      procedure DeletarItens;
    public
      destructor Destroy; override;
      class function New: iVenda;
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

{ TModelVenda }

function TModelVenda.Cliente(AValue: Integer): iVenda;
begin
  Result := Self;
  FCliente := AValue;
end;

function TModelVenda.Cliente: Integer;
begin
  Result := FCliente;
end;

function TModelVenda.Codigo(AValue: Integer): iVenda;
begin
  Result := Self;
  FCodigo := AValue;
end;

function TModelVenda.Codigo: Integer;
begin
  Result := FCodigo;
end;

constructor TModelVenda.Create;
begin

end;

function TModelVenda.Criar: iVenda;
begin
  try
    Dm.FDConnection1.StartTransaction;

    SalvarVenda(False);
    SalvarItens(FCodigo, False);

    Dm.FDConnection1.Commit;
  except
    Dm.FDConnection1.Rollback;
  end;
end;

function TModelVenda.Data(AValue: TDateTime): iVenda;
begin
  Result := Self;
  FData := AValue;
end;

function TModelVenda.Data: TDateTime;
begin
  Result := FData;
end;

function TModelVenda.Deletar: iVenda;
begin
  try
    Dm.FDConnection1.StartTransaction;

    DeletarItens;
    DeletarVenda;

    Dm.FDConnection1.Commit;
  except
    Dm.FDConnection1.Rollback;
  end;
end;

procedure TModelVenda.DeletarItens;
begin
  var LSql := 'delete from venda_item where venda_id = %d';
  TUtils.MinhaQuery(Format(LSql, [FCodigo]), True);
end;

procedure TModelVenda.DeletarVenda;
begin
  var LSql := 'delete from venda where id = %d';
  TUtils.MinhaQuery(Format(LSql, [FCodigo]), True);
end;

destructor TModelVenda.Destroy;
begin

  inherited;
end;

function TModelVenda.Editar: iVenda;
begin
  try
    Dm.FDConnection1.StartTransaction;

    SalvarVenda(True);
    SalvarItens(FCodigo, True);

    Dm.FDConnection1.Commit;
  except
    Dm.FDConnection1.Rollback;
  end;
end;

function TModelVenda.GerarRelatorio(var AClientDataSet: TClientDataSet): iVenda;
begin
  Result := Self;

  AClientDataSet := TClientDataSet.Create(nil);
  AClientDataSet.FieldDefs.Add('CodigoVenda', ftInteger);
  AClientDataSet.FieldDefs.Add('Data', ftDate);
  AClientDataSet.FieldDefs.Add('ProdutoId', ftInteger);
  AClientDataSet.FieldDefs.Add('Descricao', ftString, 50);
  AClientDataSet.FieldDefs.Add('Unitario', ftFloat);
  AClientDataSet.FieldDefs.Add('Quantidade', ftFloat);
  AClientDataSet.FieldDefs.Add('Total', ftFloat);
  AClientDataSet.CreateDataSet;

  var LSql := Concat(
    'select v.id, ',
           'cast(v.data_hora as date) as Data, ',
           'vi.produto_id, ',
           'p.descricao, ',
           'vi.preco_unitario, ',
           'vi.quantidade, ',
           'vi.total ',
      'from venda v join venda_item vi on (vi.venda_id = v.id) ',
                   'join produto p on (vi.produto_id = p.id) ',
     'where v.status = ''E'' ',
       'and v.cliente_id = %d ',
     'order by v.id, p.descricao '
  );

  var LQry := TUtils.MinhaQuery(Format(LSql, [FCliente]), false);
  try
    LQry.First;
    while not LQry.Eof do begin
      AClientDataSet.Append;
      AClientDataSet.FieldByName('CodigoVenda').AsInteger :=  LQry.FieldByName('id').AsInteger;
      AClientDataSet.FieldByName('Data').AsDateTime := LQry.FieldByName('data').AsDateTime;
      AClientDataSet.FieldByName('ProdutoId').AsInteger := LQry.FieldByName('produto_id').AsInteger;
      AClientDataSet.FieldByName('Descricao').AsString := LQry.FieldByName('descricao').AsString;
      AClientDataSet.FieldByName('Unitario').AsFloat := LQry.FieldByName('preco_unitario').AsFloat;
      AClientDataSet.FieldByName('Quantidade').AsFloat := LQry.FieldByName('quantidade').AsFloat;
      AClientDataSet.FieldByName('Total').AsFloat := LQry.FieldByName('total').AsFloat;
      AClientDataSet.Post;

      LQry.Next;
    end;
  finally
    LQry.Free;
  end;
end;

function TModelVenda.Itens(AClientDataSet: TClientDataSet): iVenda;
begin
  Result := Self;
  FItens := AClientDataSet;
end;

function TModelVenda.Listar(AFilter: String;
  var AClientDataSet: TClientDataSet): iVenda;
begin
  Result := Self;

  AClientDataSet := TClientDataSet.Create(nil);
  AClientDataSet.FieldDefs.Add('Codigo', ftInteger);
  AClientDataSet.FieldDefs.Add('ClienteId', ftInteger);
  AClientDataSet.FieldDefs.Add('ClienteNome', ftString, 50);
  AClientDataSet.FieldDefs.Add('Data', ftDate);
  AClientDataSet.FieldDefs.Add('Total', ftFloat);
  AClientDataSet.FieldDefs.Add('Status', ftString, 10);
  AClientDataSet.CreateDataSet;

  var LSql := Concat(
    'select v.id, ',
	         'v.cliente_id, ',
	         'c.nome, ',
	         'Cast(substring(cast(v.data_hora as varchar) from 1 for 10) as Date) as Data, ',
	         'v.total, ',
	         'case when v.status = ''E'' then ',
	         ' ''Efetivada'' ',
	         'else ',
	         ' ''Pendente'' end as Status ',
      'from venda v join cliente c on(c.id = v.cliente_id) ',
      'order by id '
  );

  var LQry := TUtils.MinhaQuery(LSql, false);
  try
    LQry.First;
    while not LQry.Eof do begin
      AClientDataSet.Append;
      AClientDataSet.FieldByName('Codigo').AsInteger := LQry.FieldByName('id').AsInteger;
      AClientDataSet.FieldByName('ClienteId').AsInteger :=  LQry.FieldByName('cliente_id').AsInteger;
      AClientDataSet.FieldByName('ClienteNome').AsString := LQry.FieldByName('nome').AsString;
      AClientDataSet.FieldByName('Data').AsDateTime := LQry.FieldByName('data').AsDateTime;
      AClientDataSet.FieldByName('Total').AsFloat := LQry.FieldByName('total').AsFloat;
      AClientDataSet.FieldByName('Status').AsString := LQry.FieldByName('status').AsString;
      AClientDataSet.Post;

      LQry.Next;
    end;
  finally
    LQry.Free;
  end;
end;

function TModelVenda.ListarItens(var AClientDataSet: TClientDataSet): iVenda;
begin
  Result := Self;

  AClientDataSet := TClientDataSet.Create(nil);
  AClientDataSet.FieldDefs.Add('Codigo', ftInteger);
  AClientDataSet.FieldDefs.Add('Descricao', ftString, 50);
  AClientDataSet.FieldDefs.Add('Quantidade', ftFloat);
  AClientDataSet.FieldDefs.Add('PrecoUnitario', ftFloat);
  AClientDataSet.FieldDefs.Add('Total', ftFloat);
  AClientDataSet.CreateDataSet;

  var LSql := Concat(
    'select vi.produto_id, ',
  	    	 'p.descricao, ',
  		     'vi.quantidade, ',
  		     'vi.preco_unitario, ',
  		     'vi.total ',
      'from venda_item vi join produto p on(p.id = vi.produto_id) ',
     'where vi.venda_id = %d '
  );

  var LQry := TUtils.MinhaQuery(Format(LSql, [FCodigo]), false);
  try
    LQry.First;
    while not LQry.Eof do begin
      AClientDataSet.Append;
      AClientDataSet.FieldByName('Codigo').AsInteger := LQry.FieldByName('produto_id').AsInteger;
      AClientDataSet.FieldByName('Descricao').AsString := LQry.FieldByName('descricao').AsString;
      AClientDataSet.FieldByName('Quantidade').AsFloat := LQry.FieldByName('quantidade').AsFloat;
      AClientDataSet.FieldByName('PrecoUnitario').AsFloat := LQry.FieldByName('preco_unitario').AsFloat;
      AClientDataSet.FieldByName('Total').AsFloat := LQry.FieldByName('total').AsFloat;
      AClientDataSet.Post;

      LQry.Next;
    end;
  finally
    LQry.Free;
  end;
end;

class function TModelVenda.New: iVenda;
begin
  Result := Self.Create;
end;

function TModelVenda.Status(AValue: String): iVenda;
begin
  Result := Self;
  FStatus := AValue;
end;

procedure TModelVenda.SalvarItens(AVendaId: Integer; AEdicao: Boolean);
begin
  var LSql: String;

  if AEdicao then
    DeletarItens;

  LSql := Concat(
    'insert into venda_item (venda_id, produto_id, quantidade, preco_unitario, total) ',
                    'values (:venda_id, :produto_id, :quantidade, :unitario, :total) '
  );

  var LQry := TUtils.CriaQuery;
  try
    FItens.First;
    while not FItens.Eof do begin
      LQry.SQL.Clear;
      LQry.SQL.Add(LSql);
      LQry.ParamByName('venda_id').AsInteger := AVendaId;
      LQry.ParamByName('produto_id').AsInteger := FItens.FieldByName('Codigo').AsInteger;
      LQry.ParamByName('quantidade').AsFloat := FItens.FieldByName('Quantidade').AsFloat;
      LQry.ParamByName('unitario').AsFloat := FItens.FieldByName('PrecoUnitario').AsFloat;
      LQry.ParamByName('total').AsFloat := FItens.FieldByName('Total').AsFloat;
      LQry.ExecSQL;

      FItens.Next;
    end;
  finally
    LQry.Free;
  end;
end;

procedure TModelVenda.SalvarVenda(AEdicao: Boolean);
begin
  var Lsql: String;
  if not AEdicao then begin
    LSql := Concat(
      'insert into venda (cliente_id, data_hora, total, status) ',
                ' values (:cliente_id, :data_hora, :total, :status) returning id '
    );
  end else begin
    LSql := Concat(
      ' update venda set cliente_id = :cliente_id, ',
                        'total = :total, ',
                        'status = :status ',
      ' where id = :id '
    );
  end;

  var LQry := TUtils.CriaQuery;
  try
    LQry.SQL.Clear;
    LQry.SQL.Add(Lsql);
    LQry.ParamByName('cliente_id').AsInteger := Cliente;
    LQry.ParamByName('total').AsFloat := Total;
    LQry.ParamByName('status').AsString := Status;
    if AEdicao then begin
      LQry.ParamByName('id').AsInteger := FCodigo;
      LQry.ExecSQL;
    end else begin
      LQry.ParamByName('data_hora').AsDateTime := Now;
      LQry.Open;
      FCodigo := LQry.FieldByName('id').AsInteger;
    end;
  finally
    LQry.Free;
  end;
end;

function TModelVenda.Status: String;
begin
  Result := FStatus;
end;

function TModelVenda.Total(AValue: Double): iVenda;
begin
  Result := Self;
  FTotal := AValue;
end;

function TModelVenda.Total: Double;
begin
  Result := FTotal;
end;

end.
