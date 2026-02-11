unit Application.Ports.IPesagemRepository;

interface

uses
  Domain.Entities.Pesagem;

type
  IPesagemRepository = interface
    ['{6A9D9A76-00A1-4147-8E88-3309A3A66580}']
    procedure Adicionar(const APesagem: TPesagem);
  end;

implementation

end.
