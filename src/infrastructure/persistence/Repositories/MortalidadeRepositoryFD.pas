unit MortalidadeRepositoryFD;

interface

uses
  FireDAC.Comp.Client,
  IMortalidadeRepository,
  Mortalidade;

type
  TMortalidadeRepositoryFD = class(TInterfacedObject, IMortalidadeRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    procedure Inserir(const AMortalidade: TMortalidade);
    function ObterTotalMortes(AIdLote: Integer): Integer;
  end;

implementation

constructor TMortalidadeRepositoryFD.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

procedure TMortalidadeRepositoryFD.Inserir(const AMortalidade: TMortalidade);
begin
  // Exemplo: chamada de stored procedure de mortalidade.
end;

function TMortalidadeRepositoryFD.ObterTotalMortes(AIdLote: Integer): Integer;
begin
  Result := 0;
end;

end.
