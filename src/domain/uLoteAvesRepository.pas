unit uLoteAvesRepository;

interface

type
  ILoteAvesRepository = interface
    ['{5DD8EE45-A5A3-4933-86D3-5CD9ED8C5DFD}']
    function ObterQuantidadeInicial(AIdLote: Integer): Integer;
    function ObterTotalMortes(AIdLote: Integer): Integer;
    procedure RegistrarMortalidade(AIdLote: Integer; AQuantidade: Integer; AObservacao: string);
  end;

implementation

end.
