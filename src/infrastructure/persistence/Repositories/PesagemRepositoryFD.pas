unit Infrastructure.Persistence.Repositories.PesagemRepositoryFD;

interface

uses
  System.SysUtils,
  Application.Ports.IPesagemRepository,
  Domain.Entities.Pesagem;

type
  TPesagemRepositoryFD = class(TInterfacedObject, IPesagemRepository)
  public
    procedure Adicionar(const APesagem: TPesagem);
  end;

implementation

procedure TPesagemRepositoryFD.Adicionar(const APesagem: TPesagem);
begin
  if APesagem = nil then
    raise Exception.Create('Pesagem não informada para persistência.');

  { Exemplo: INSERT via FireDAC. }
end;

end.
