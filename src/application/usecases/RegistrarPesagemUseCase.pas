unit RegistrarPesagemUseCase;

interface

uses
  RegistrarPesagemDTO,
  Pesagem,
  IPesagemRepository,
  ILoteRepository;

type
  TRegistrarPesagemUseCase = class
  private
    FLoteRepository: ILoteRepository;
    FPesagemRepository: IPesagemRepository;
  public
    constructor Create(const ALoteRepository: ILoteRepository; const APesagemRepository: IPesagemRepository);
    procedure Executar(const AInput: TRegistrarPesagemDTO);
  end;

implementation

constructor TRegistrarPesagemUseCase.Create(const ALoteRepository: ILoteRepository;
  const APesagemRepository: IPesagemRepository);
begin
  FLoteRepository := ALoteRepository;
  FPesagemRepository := APesagemRepository;
end;

procedure TRegistrarPesagemUseCase.Executar(const AInput: TRegistrarPesagemDTO);
var
  LPesagem: TPesagem;
begin
  LPesagem := TPesagem.Create(AInput.IdLote, AInput.DataPesagem, AInput.QuantidadePesada, AInput.PesoMedio);
  try
    FPesagemRepository.Inserir(LPesagem);
  finally
    LPesagem.Free;
  end;
end;

end.
