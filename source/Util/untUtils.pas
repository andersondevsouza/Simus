unit untUtils;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, untDm, System.SysUtils;

Type
  StatusCpf = (
    stInvalido,
    stDuplicado
  );

Type
  TUtils = class
    private
    public
      class function MinhaQuery(ASql: String; AExec: Boolean): TFDQuery;
      class function CriaQuery: TFDQuery;
      class function StrVazio(AValue: String): Boolean;
  end;


implementation

class function TUtils.CriaQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Dm.FDConnection1;
end;

class function TUtils.MinhaQuery(ASql: String; AExec: Boolean): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Dm.FDConnection1;
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Add(Asql);
  if AExec then
    Result.ExecSQL
  else
    Result.Open;
end;

class function TUtils.StrVazio(AValue: String): Boolean;
begin
  Result := False;
  if Trim(AValue) = '' then
    Result := True;
end;

end.
