unit Infrastructure.Persistence.Repositories.LoteRepositoryFD;

interface

uses
  System.SysUtils,
  Application.Ports.ILoteRepository,
  Domain.Entities.Lote;

type
  TLoteRepositoryFD = class(TInterfacedObject, ILoteRepository)
  public
    function ObterPorId(AId: Integer): TLote;
    procedure Salvar(const ALote: TLote);
  end;

implementation

function TLoteRepositoryFD.ObterPorId(AId: Integer): TLote;
begin
  Result := TLote.Create(AId, 'Lote Exemplo', Date, 1000);
end;

procedure TLoteRepositoryFD.Salvar(const ALote: TLote);
begin
  if ALote = nil then
    raise Exception.Create('Lote não informado para salvar.');

  { Exemplo: persistir alterações via FireDAC. }
end;

end.
