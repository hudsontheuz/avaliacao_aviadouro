unit infrastructure.persistence.Repositories.MortalidadeRepositoryFD;

interface

uses
  FireDAC.Comp.Client,
  application.ports.IMortalidadeRepository;

type
  TMortalidadeRepositoryFD = class(TInterfacedObject, IMortalidadeRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    procedure RegistrarMortalidade(AIdLote: Integer; AQuantidadeMorta: Integer; const AObservacao: string);
    function ObterTotalMortes(AIdLote: Integer): Integer;
  end;

implementation

uses
  FireDAC.Comp.DataSet;

constructor TMortalidadeRepositoryFD.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TMortalidadeRepositoryFD.ObterTotalMortes(AIdLote: Integer): Integer;
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

procedure TMortalidadeRepositoryFD.RegistrarMortalidade(AIdLote,
  AQuantidadeMorta: Integer; const AObservacao: string);
var
  Sp: TFDStoredProc;
begin
  Sp := TFDStoredProc.Create(nil);
  try
    Sp.Connection := FConnection;
    Sp.StoredProcName := 'SP_INSERIR_MORTALIDADE';
    Sp.ParamByName('P_ID_LOTE').AsInteger := AIdLote;
    Sp.ParamByName('P_QTD_MORTA').AsInteger := AQuantidadeMorta;
    Sp.ParamByName('P_OBSERVACAO').AsString := AObservacao;
    Sp.ExecProc;
  finally
    Sp.Free;
  end;
end;

end.
