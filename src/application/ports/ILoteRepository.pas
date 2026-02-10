unit ILoteRepository;

interface

uses
  Lote;

type
  ILoteRepository = interface
    ['{5B6EC071-14B3-4213-B2D0-2B0DFA999CF9}']
    function ObterPorId(AIdLote: Integer): TLote;
    procedure Atualizar(const ALote: TLote);
  end;

implementation

end.
