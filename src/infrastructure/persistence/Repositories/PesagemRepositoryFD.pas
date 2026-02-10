unit infrastructure.persistence.Repositories.PesagemRepositoryFD;

interface

uses
  FireDAC.Comp.Client,
  application.ports.IPesagemRepository;

type
  TPesagemRepositoryFD = class(TInterfacedObject, IPesagemRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    procedure RegistrarPesagem(AIdLote: Integer; AQuantidadePesada: Integer; APesoMedio: Double);
    function ObterTotalPesado(AIdLote: Integer): Integer;
  end;

implementation

uses
  FireDAC.Comp.DataSet;

constructor TPesagemRepositoryFD.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TPesagemRepositoryFD.ObterTotalPesado(AIdLote: Integer): Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'SELECT COALESCE(SUM(QUANTIDADE_PESADA), 0) AS TOTAL_PESADO ' +
      'FROM PESAGEM WHERE ID_LOTE = :ID_LOTE';
    Qry.ParamByName('ID_LOTE').AsInteger := AIdLote;
    Qry.Open;
    Result := Qry.FieldByName('TOTAL_PESADO').AsInteger;
  finally
    Qry.Free;
  end;
end;

procedure TPesagemRepositoryFD.RegistrarPesagem(AIdLote, AQuantidadePesada: Integer;
  APesoMedio: Double);
var
  Sp: TFDStoredProc;
begin
  Sp := TFDStoredProc.Create(nil);
  try
    Sp.Connection := FConnection;
    Sp.StoredProcName := 'SP_INSERIR_PESAGEM';
    Sp.ParamByName('P_ID_LOTE').AsInteger := AIdLote;
    Sp.ParamByName('P_QTD_PESADA').AsInteger := AQuantidadePesada;
    Sp.ParamByName('P_PESO_MEDIO').AsFloat := APesoMedio;
    Sp.ExecProc;
  finally
    Sp.Free;
  end;
end;

end.
