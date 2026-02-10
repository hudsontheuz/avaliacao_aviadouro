unit infrastructure.persistence.Repositories.LoteRepositoryFD;

interface

uses
  FireDAC.Comp.Client,
  application.ports.ILoteRepository;

type
  TLoteRepositoryFD = class(TInterfacedObject, ILoteRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function ObterQuantidadeInicial(AIdLote: Integer): Integer;
    function Existe(AIdLote: Integer): Boolean;
  end;

implementation

uses
  FireDAC.Comp.DataSet;

constructor TLoteRepositoryFD.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TLoteRepositoryFD.Existe(AIdLote: Integer): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT 1 FROM LOTE_AVES WHERE ID_LOTE = :ID_LOTE';
    Qry.ParamByName('ID_LOTE').AsInteger := AIdLote;
    Qry.Open;
    Result := not Qry.IsEmpty;
  finally
    Qry.Free;
  end;
end;

function TLoteRepositoryFD.ObterQuantidadeInicial(AIdLote: Integer): Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT QUANTIDADE_INICIAL FROM LOTE_AVES WHERE ID_LOTE = :ID_LOTE';
    Qry.ParamByName('ID_LOTE').AsInteger := AIdLote;
    Qry.Open;
    Result := Qry.FieldByName('QUANTIDADE_INICIAL').AsInteger;
  finally
    Qry.Free;
  end;
end;

end.
