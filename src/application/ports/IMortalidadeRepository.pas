unit Application.Ports.IMortalidadeRepository;

interface

uses
  Domain.Entities.Mortalidade;

type
  IMortalidadeRepository = interface
    ['{2AC03D2E-2D6D-4E45-B853-ACB10A2D6E9D}']
    procedure Adicionar(const AMortalidade: TMortalidade);
  end;

implementation

end.
