unit uRegistrarMortalidadeUseCase;

interface

uses
  SysUtils,
  uLoteAvesDomain,
  uMortalidadeDomain,
  uLoteAvesRepository;

type
  TRegistrarMortalidadeInput = record
    IdLote: Integer;
    QuantidadeMorta: Integer;
    Observacao: string;
    class function Criar(AIdLote: Integer; AQuantidadeMorta: Integer; AObservacao: string): TRegistrarMortalidadeInput; static;
  end;

  TRegistrarMortalidadeOutput = record
    PercentualMortalidade: Double;
    class function Criar(APercentualMortalidade: Double): TRegistrarMortalidadeOutput; static;
  end;

  TRegistrarMortalidadeUseCase = class
  private
    FRepositorio: ILoteAvesRepository;
  public
    constructor Create(ARepositorio: ILoteAvesRepository);
    function Executar(const AInput: TRegistrarMortalidadeInput): TRegistrarMortalidadeOutput;
  end;

implementation

{ TRegistrarMortalidadeInput }

class function TRegistrarMortalidadeInput.Criar(AIdLote,
  AQuantidadeMorta: Integer; AObservacao: string): TRegistrarMortalidadeInput;
begin
  Result.IdLote := AIdLote;
  Result.QuantidadeMorta := AQuantidadeMorta;
  Result.Observacao := AObservacao;
end;

{ TRegistrarMortalidadeOutput }

class function TRegistrarMortalidadeOutput.Criar(
  APercentualMortalidade: Double): TRegistrarMortalidadeOutput;
begin
  Result.PercentualMortalidade := APercentualMortalidade;
end;

{ TRegistrarMortalidadeUseCase }

constructor TRegistrarMortalidadeUseCase.Create(ARepositorio: ILoteAvesRepository);
begin
  FRepositorio := ARepositorio;
end;

function TRegistrarMortalidadeUseCase.Executar(
  const AInput: TRegistrarMortalidadeInput): TRegistrarMortalidadeOutput;
var
  Lote: TLoteAves;
  Mortalidade: TMortalidade;
  TotalMortes: Integer;
  PercentualMortalidade: Double;
begin
  Mortalidade := TMortalidade.Create(AInput.IdLote, Date, AInput.QuantidadeMorta, AInput.Observacao);
  try
    Mortalidade.Validar;

    Lote := TLoteAves.Create(
      AInput.IdLote,
      'Lote carregado do repositório',
      FRepositorio.ObterQuantidadeInicial(AInput.IdLote)
    );
    try
      TotalMortes := FRepositorio.ObterTotalMortes(AInput.IdLote) + AInput.QuantidadeMorta;

      PercentualMortalidade := Lote.CalcularPercentualMortalidade(TotalMortes);
      if PercentualMortalidade > 100 then
        raise Exception.Create('Mortalidade acumulada não pode ultrapassar 100%.');

      FRepositorio.RegistrarMortalidade(AInput.IdLote, AInput.QuantidadeMorta, AInput.Observacao);
      Result := TRegistrarMortalidadeOutput.Criar(PercentualMortalidade);
    finally
      Lote.Free;
    end;
  finally
    Mortalidade.Free;
  end;
end;

end.
