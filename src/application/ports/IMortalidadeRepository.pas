unit application.ports.IMortalidadeRepository;

interface

type
  IMortalidadeRepository = interface
    ['{D73A7BEE-C931-4B2A-8910-6464F6AAB136}']
    procedure RegistrarMortalidade(AIdLote: Integer; AQuantidadeMorta: Integer; const AObservacao: string);
    function ObterTotalMortes(AIdLote: Integer): Integer;
  end;

implementation

end.
