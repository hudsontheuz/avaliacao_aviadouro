unit Application.Ports.ILoteRepository;

interface

uses
  Domain.Entities.Lote;

type
  ILoteRepository = interface
    ['{3C14AD7E-A131-43A7-A69D-96B17A7AF8E7}']
    function ObterPorId(AId: Integer): TLote;
    procedure Salvar(const ALote: TLote);
  end;

implementation

end.
