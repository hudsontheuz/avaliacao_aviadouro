unit Application.UseCases.ObterResumoLoteUseCase;

interface

uses
  Application.Ports.ILoteRepository,
  Application.DTO.ResumoLoteDTO,
  Domain.Services.IndicadorSaudeService,
  Domain.Entities.Lote;

type
  TObterResumoLoteUseCase = class
  private
    FLoteRepository: ILoteRepository;
  public
    constructor Create(const ALoteRepository: ILoteRepository);
    function Executar(ALoteId: Integer): TResumoLoteDTO;
  end;

implementation

constructor TObterResumoLoteUseCase.Create(const ALoteRepository: ILoteRepository);
begin
  FLoteRepository := ALoteRepository;
end;

function TObterResumoLoteUseCase.Executar(ALoteId: Integer): TResumoLoteDTO;
var
  LLote: TLote;
begin
  LLote := FLoteRepository.ObterPorId(ALoteId);
  try
    Result.LoteId := LLote.Id;
    Result.Descricao := LLote.Descricao;
    Result.QuantidadeInicial := LLote.QuantidadeInicial;
    Result.PesoMedioGeral := LLote.PesoMedioGeral;
    Result.TotalMortalidade := LLote.TotalMortalidade;
    Result.PercentualMortalidade := LLote.PercentualMortalidade.Valor;
    Result.IndicadorCor := TIndicadorSaudeService.ObterCor(LLote.PercentualMortalidade);
  finally
    LLote.Free;
  end;
end;

end.
