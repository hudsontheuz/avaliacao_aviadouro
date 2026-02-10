unit domain.services.IndicadorSaudeService;

interface

uses
  domain.valueobjects.Percentual;

type
  TFaixaSaude = (fsVerde, fsAmarelo, fsVermelho);

  TIndicadorSaudeService = class
  public
    class function Classificar(APercentualMortalidade: TPercentual): TFaixaSaude; static;
  end;

implementation

class function TIndicadorSaudeService.Classificar(
  APercentualMortalidade: TPercentual): TFaixaSaude;
begin
  if APercentualMortalidade.Valor < 5 then
    Exit(fsVerde);

  if APercentualMortalidade.Valor <= 10 then
    Exit(fsAmarelo);

  Result := fsVermelho;
end;

end.
