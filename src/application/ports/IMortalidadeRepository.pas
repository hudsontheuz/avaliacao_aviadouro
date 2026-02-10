unit IMortalidadeRepository;

interface

uses
  Mortalidade;

type
  IMortalidadeRepository = interface
    ['{AF2D3BA5-3E4A-43A6-9D28-93D95D418D12}']
    procedure Inserir(const AMortalidade: TMortalidade);
    function ObterTotalMortes(AIdLote: Integer): Integer;
  end;

implementation

end.
