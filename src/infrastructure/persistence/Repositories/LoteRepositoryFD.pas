unit LoteRepositoryFD;

interface

uses
  FireDAC.Comp.Client,
  ILoteRepository,
  Lote;

type
  TLoteRepositoryFD = class(TInterfacedObject, ILoteRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function ObterPorId(AIdLote: Integer): TLote;
    procedure Atualizar(const ALote: TLote);
  end;

implementation

constructor TLoteRepositoryFD.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

procedure TLoteRepositoryFD.Atualizar(const ALote: TLote);
begin
  // Exemplo: persistir dados do lote com FireDAC.
end;

function TLoteRepositoryFD.ObterPorId(AIdLote: Integer): TLote;
begin
  // Exemplo simplificado.
  Result := TLote.Create(AIdLote, 'Lote Exemplo', 1000);
  Result.AtualizarPesoMedio(2.35);
end;

end.
