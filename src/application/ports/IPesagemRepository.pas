unit application.ports.IPesagemRepository;

interface

type
  IPesagemRepository = interface
    ['{DC790EE6-AE6D-47A6-9FC5-94850B6F3BE0}']
    procedure RegistrarPesagem(AIdLote: Integer; AQuantidadePesada: Integer; APesoMedio: Double);
    function ObterTotalPesado(AIdLote: Integer): Integer;
  end;

implementation

end.
