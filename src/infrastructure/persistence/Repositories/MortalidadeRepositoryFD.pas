unit Infrastructure.Persistence.Repositories.MortalidadeRepositoryFD;

interface

uses
  System.SysUtils,
  Application.Ports.IMortalidadeRepository,
  Domain.Entities.Mortalidade;

type
  TMortalidadeRepositoryFD = class(TInterfacedObject, IMortalidadeRepository)
  public
    procedure Adicionar(const AMortalidade: TMortalidade);
  end;

implementation

procedure TMortalidadeRepositoryFD.Adicionar(const AMortalidade: TMortalidade);
begin
  if AMortalidade = nil then
    raise Exception.Create('Mortalidade não informada para persistência.');

  { Exemplo: INSERT via FireDAC. }
end;

end.
