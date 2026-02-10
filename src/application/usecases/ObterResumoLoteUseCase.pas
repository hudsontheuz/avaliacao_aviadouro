unit application.usecases.ObterResumoLoteUseCase;

interface

uses
  application.dto.ResumoLoteDTO,
  application.ports.ILoteRepository,
  application.ports.IPesagemRepository,
  application.ports.IMortalidadeRepository,
  domain.entities.Lote,
  domain.services.IndicadorSaudeService;

type
  TObterResumoLoteUseCase = class
  private
    FLoteRepository: ILoteRepository;
    FPesagemRepository: IPesagemRepository;
    FMortalidadeRepository: IMortalidadeRepository;
    function IndicadorToString(AFaixa: TFaixaSaude): string;
  public
    constructor Create(ALoteRepository: ILoteRepository;
      APesagemRepository: IPesagemRepository;
      AMortalidadeRepository: IMortalidadeRepository);
    function Executar(AIdLote: Integer): TResumoLoteDTO;
  end;

implementation

uses
  domain.valueobjects.Percentual;

constructor TObterResumoLoteUseCase.Create(ALoteRepository: ILoteRepository;
  APesagemRepository: IPesagemRepository;
  AMortalidadeRepository: IMortalidadeRepository);
begin
  FLoteRepository := ALoteRepository;
  FPesagemRepository := APesagemRepository;
  FMortalidadeRepository := AMortalidadeRepository;
end;

function TObterResumoLoteUseCase.IndicadorToString(AFaixa: TFaixaSaude): string;
begin
  case AFaixa of
    fsVerde: Result := 'VERDE';
    fsAmarelo: Result := 'AMARELO';
  else
    Result := 'VERMELHO';
  end;
end;

function TObterResumoLoteUseCase.Executar(AIdLote: Integer): TResumoLoteDTO;
var
  Lote: TLote;
  TotalMortes: Integer;
  TotalPesado: Integer;
  Percentual: TPercentual;
  Indicador: TFaixaSaude;
begin
  Lote := TLote.Create(
    AIdLote,
    'Lote carregado por repositório',
    FLoteRepository.ObterQuantidadeInicial(AIdLote)
  );
  try
    TotalMortes := FMortalidadeRepository.ObterTotalMortes(AIdLote);
    TotalPesado := FPesagemRepository.ObterTotalPesado(AIdLote);
    Percentual := Lote.CalcularPercentualMortalidade(TotalMortes);
    Indicador := TIndicadorSaudeService.Classificar(Percentual);

    Result.IdLote := AIdLote;
    Result.QuantidadeInicial := Lote.QuantidadeInicial;
    Result.TotalPesado := TotalPesado;
    Result.TotalMortes := TotalMortes;
    Result.PercentualMortalidade := Percentual.Valor;
    Result.IndicadorSaude := IndicadorToString(Indicador);
  finally
    Lote.Free;
  end;
end;

end.
