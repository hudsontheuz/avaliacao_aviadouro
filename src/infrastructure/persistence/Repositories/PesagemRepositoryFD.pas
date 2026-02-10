unit PesagemRepositoryFD;

interface

uses
  FireDAC.Comp.Client,
  IPesagemRepository,
  Pesagem;

type
  TPesagemRepositoryFD = class(TInterfacedObject, IPesagemRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    procedure Inserir(const APesagem: TPesagem);
    function ObterTotalPesado(AIdLote: Integer): Integer;
  end;

implementation

constructor TPesagemRepositoryFD.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

procedure TPesagemRepositoryFD.Inserir(const APesagem: TPesagem);
begin
  // Exemplo: chamada de stored procedure de pesagem.
end;

function TPesagemRepositoryFD.ObterTotalPesado(AIdLote: Integer): Integer;
begin
  Result := 0;
end;

end.
