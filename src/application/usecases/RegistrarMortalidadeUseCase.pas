unit Application.UseCases.RegistrarMortalidadeUseCase;

interface

uses
  Application.Ports.ILoteRepository,
  Application.Ports.IMortalidadeRepository,
  Application.DTO.RegistrarMortalidadeDTO,
  Domain.Entities.Mortalidade,
  Domain.Entities.Lote;

type
  TRegistrarMortalidadeUseCase = class
  private
    FLoteRepository: ILoteRepository;
    FMortalidadeRepository: IMortalidadeRepository;
  public
    constructor Create(const ALoteRepository: ILoteRepository; const AMortalidadeRepository: IMortalidadeRepository);
    procedure Executar(const ADTO: TRegistrarMortalidadeDTO);
  end;

implementation

constructor TRegistrarMortalidadeUseCase.Create(const ALoteRepository: ILoteRepository; const AMortalidadeRepository: IMortalidadeRepository);
begin
  FLoteRepository := ALoteRepository;
  FMortalidadeRepository := AMortalidadeRepository;
end;

procedure TRegistrarMortalidadeUseCase.Executar(const ADTO: TRegistrarMortalidadeDTO);
var
  LLote: TLote;
  LMortalidade: TMortalidade;
  LPercentualAtual: Double;
begin
  LLote := FLoteRepository.ObterPorId(ADTO.LoteId);
  try
    LPercentualAtual := ((LLote.TotalMortalidade + ADTO.Quantidade) / LLote.QuantidadeInicial) * 100;
    LMortalidade := TMortalidade.Create(ADTO.LoteId, ADTO.Quantidade, ADTO.DataRegistro, LPercentualAtual);
    try
      LLote.AplicarMortalidade(LMortalidade);
      FMortalidadeRepository.Adicionar(LMortalidade);
      FLoteRepository.Salvar(LLote);
    finally
      LMortalidade.Free;
    end;
  finally
    LLote.Free;
  end;
end;

end.
