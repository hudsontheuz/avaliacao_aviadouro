unit IPesagemRepository;

interface

uses
  Pesagem;

type
  IPesagemRepository = interface
    ['{8F145D59-BEA9-4E09-A4EE-BB2DA4A68A8F}']
    procedure Inserir(const APesagem: TPesagem);
    function ObterTotalPesado(AIdLote: Integer): Integer;
  end;

implementation

end.
