unit uLoteAvesRepositoryFD;

interface

uses
  FireDAC.Comp.Client,
  uLoteAvesRepository;

type
  TLoteAvesRepositoryFD = class(TInterfacedObject, ILoteAvesRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);

    function ObterQuantidadeInicial(AIdLote: Integer): Integer;
    function ObterTotalMortes(AIdLote: Integer): Integer;
    procedure RegistrarMortalidade(AIdLote: Integer; AQuantidade: Integer; AObservacao: string);
  end;

implementation

uses
  FireDAC.Comp.DataSet,
  FireDAC.Stan.Param,
  SysUtils;

constructor TLoteAvesRepositoryFD.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TLoteAvesRepositoryFD.ObterQuantidadeInicial(AIdLote: Integer): Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT QUANTIDADE_INICIAL FROM LOTE_AVES WHERE ID_LOTE = :ID_LOTE';
    Qry.ParamByName('ID_LOTE').AsInteger := AIdLote;
    Qry.Open;

    if Qry.IsEmpty then
      raise Exception.Create('Lote não encontrado.');

    Result := Qry.FieldByName('QUANTIDADE_INICIAL').AsInteger;
  finally
    Qry.Free;
  end;
end;

function TLoteAvesRepositoryFD.ObterTotalMortes(AIdLote: Integer): Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'SELECT COALESCE(SUM(QUANTIDADE_MORTA), 0) AS TOTAL_MORTES ' +
      'FROM MORTALIDADE WHERE ID_LOTE = :ID_LOTE';
    Qry.ParamByName('ID_LOTE').AsInteger := AIdLote;
    Qry.Open;

    Result := Qry.FieldByName('TOTAL_MORTES').AsInteger;
  finally
    Qry.Free;
  end;
end;

procedure TLoteAvesRepositoryFD.RegistrarMortalidade(AIdLote,
  AQuantidade: Integer; AObservacao: string);
var
  StoredProc: TFDStoredProc;
begin
  StoredProc := TFDStoredProc.Create(nil);
  try
    StoredProc.Connection := FConnection;
    StoredProc.StoredProcName := 'SP_INSERIR_MORTALIDADE';
    StoredProc.ParamByName('P_ID_LOTE').AsInteger := AIdLote;
    StoredProc.ParamByName('P_QTD_MORTA').AsInteger := AQuantidade;
    StoredProc.ParamByName('P_OBSERVACAO').AsString := AObservacao;
    StoredProc.ExecProc;
  finally
    StoredProc.Free;
  end;
end;

end.
