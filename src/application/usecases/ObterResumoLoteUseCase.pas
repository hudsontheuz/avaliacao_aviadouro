unit ObterResumoLoteUseCase;

interface

uses
  ILoteRepository,
  IMortalidadeRepository,
  ResumoLoteDTO,
  IndicadorSaudeService,
  Percentual;

type
  TObterResumoLoteUseCase = class
  private
    FLoteRepository: ILoteRepository;
    FMortalidadeRepository: IMortalidadeRepository;
    function FaixaSaudeParaTexto(AFaixa: TFaixaSaude): string;
  public
    constructor Create(const ALoteRepository: ILoteRepository; const AMortalidadeRepository: IMortalidadeRepository);
    function Executar(AIdLote: Integer): TResumoLoteDTO;
  end;

implementation

uses
  Lote;

constructor TObterResumoLoteUseCase.Create(const ALoteRepository: ILoteRepository;
  const AMortalidadeRepository: IMortalidadeRepository);
begin
  FLoteRepository := ALoteRepository;
  FMortalidadeRepository := AMortalidadeRepository;
end;

function TObterResumoLoteUseCase.Executar(AIdLote: Integer): TResumoLoteDTO;
var
  LLote: TLote;
  LTotalMortes: Integer;
  LPercentual: TPercentual;
begin
  LLote := FLoteRepository.ObterPorId(AIdLote);
  try
    LTotalMortes := FMortalidadeRepository.ObterTotalMortes(AIdLote);
    LPercentual := LLote.CalcularPercentualMortalidade(LTotalMortes);

    Result.IdLote := LLote.Id;
    Result.Descricao := LLote.Descricao;
    Result.QuantidadeInicial := LLote.QuantidadeInicial;
    Result.PesoMedioAtual := LLote.PesoMedioAtual;
    Result.TotalMortes := LTotalMortes;
    Result.PercentualMortalidade := LPercentual.Valor;
    Result.FaixaSaude := FaixaSaudeParaTexto(TIndicadorSaudeService.ObterFaixa(LPercentual));
  finally
    LLote.Free;
  end;
end;

function TObterResumoLoteUseCase.FaixaSaudeParaTexto(AFaixa: TFaixaSaude): string;
begin
  case AFaixa of
    fsVerde: Result := 'VERDE';
    fsAmarela: Result := 'AMARELA';
    fsVermelha: Result := 'VERMELHA';
  end;
end;

end.
