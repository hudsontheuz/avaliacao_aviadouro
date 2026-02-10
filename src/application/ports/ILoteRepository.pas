unit application.ports.ILoteRepository;

interface

type
  ILoteRepository = interface
    ['{5953CF37-E4D9-4034-A2EC-08E21718A4D7}']
    function ObterQuantidadeInicial(AIdLote: Integer): Integer;
    function Existe(AIdLote: Integer): Boolean;
  end;

implementation

end.
