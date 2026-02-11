unit Application.UseCases.RegistrarPesagemUseCase;

interface

uses
  Application.Ports.ILoteRepository,
  Application.Ports.IPesagemRepository,
  Application.DTO.RegistrarPesagemDTO,
  Domain.Entities.Pesagem;

type
  TRegistrarPesagemUseCase = class
  private
    FLoteRepository: ILoteRepository;
    FPesagemRepository: IPesagemRepository;
  public
    constructor Create(const ALoteRepository: ILoteRepository; const APesagemRepository: IPesagemRepository);
    procedure Executar(const ADTO: TRegistrarPesagemDTO);
  end;

implementation

constructor TRegistrarPesagemUseCase.Create(const ALoteRepository: ILoteRepository; const APesagemRepository: IPesagemRepository);
begin
  FLoteRepository := ALoteRepository;
  FPesagemRepository := APesagemRepository;
end;

procedure TRegistrarPesagemUseCase.Executar(const ADTO: TRegistrarPesagemDTO);
var
  LPesagem: TPesagem;
  LLote: TObject;
begin
  LLote := FLoteRepository.ObterPorId(ADTO.LoteId);
  LPesagem := TPesagem.Create(ADTO.LoteId, ADTO.QuantidadePesada, ADTO.PesoMedio, ADTO.DataPesagem);
  try
    FPesagemRepository.Adicionar(LPesagem);
  finally
    LPesagem.Free;
    LLote.Free;
  end;
end;

end.
