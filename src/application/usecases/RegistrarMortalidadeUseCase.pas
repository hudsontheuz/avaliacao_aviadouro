unit application.usecases.RegistrarMortalidadeUseCase;

interface

uses
  SysUtils,
  application.dto.RegistrarMortalidadeDTO,
  application.dto.ResumoLoteDTO,
  application.ports.ILoteRepository,
  application.ports.IMortalidadeRepository,
  domain.entities.Lote,
  domain.entities.Mortalidade,
  domain.services.IndicadorSaudeService,
  domain.exceptions.DomainException,
  domain.valueobjects.Percentual;

type
  TRegistrarMortalidadeUseCase = class
  private
    FLoteRepository: ILoteRepository;
    FMortalidadeRepository: IMortalidadeRepository;
    function IndicadorToString(AFaixa: TFaixaSaude): string;
  public
    constructor Create(ALoteRepository: ILoteRepository; AMortalidadeRepository: IMortalidadeRepository);
    function Executar(const AInput: TRegistrarMortalidadeDTO): TResumoLoteDTO;
  end;

implementation

constructor TRegistrarMortalidadeUseCase.Create(ALoteRepository: ILoteRepository;
  AMortalidadeRepository: IMortalidadeRepository);
begin
  FLoteRepository := ALoteRepository;
  FMortalidadeRepository := AMortalidadeRepository;
end;

function TRegistrarMortalidadeUseCase.IndicadorToString(AFaixa: TFaixaSaude): string;
begin
  case AFaixa of
    fsVerde: Result := 'VERDE';
    fsAmarelo: Result := 'AMARELO';
  else
    Result := 'VERMELHO';
  end;
end;

function TRegistrarMortalidadeUseCase.Executar(
  const AInput: TRegistrarMortalidadeDTO): TResumoLoteDTO;
var
  Lote: TLote;
  Mortalidade: TMortalidade;
  TotalMortes: Integer;
  Percentual: TPercentual;
  Indicador: TFaixaSaude;
begin
  if not FLoteRepository.Existe(AInput.IdLote) then
    raise EDomainException.Create('Lote não encontrado.');

  Mortalidade := TMortalidade.Create(AInput.IdLote, Date, AInput.QuantidadeMorta, AInput.Observacao);
  try
    Lote := TLote.Create(
      AInput.IdLote,
      'Lote carregado por repositório',
      FLoteRepository.ObterQuantidadeInicial(AInput.IdLote)
    );
    try
      TotalMortes := FMortalidadeRepository.ObterTotalMortes(AInput.IdLote) + Mortalidade.QuantidadeMorta;
      Percentual := Lote.CalcularPercentualMortalidade(TotalMortes);

      FMortalidadeRepository.RegistrarMortalidade(
        Mortalidade.IdLote,
        Mortalidade.QuantidadeMorta,
        Mortalidade.Observacao
      );

      Indicador := TIndicadorSaudeService.Classificar(Percentual);

      Result.IdLote := AInput.IdLote;
      Result.QuantidadeInicial := Lote.QuantidadeInicial;
      Result.TotalMortes := TotalMortes;
      Result.PercentualMortalidade := Percentual.Valor;
      Result.IndicadorSaude := IndicadorToString(Indicador);
    finally
      Lote.Free;
    end;
  finally
    Mortalidade.Free;
  end;
end;

end.
