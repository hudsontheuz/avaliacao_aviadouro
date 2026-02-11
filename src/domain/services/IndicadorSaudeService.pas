unit Domain.Services.IndicadorSaudeService;

interface

uses
  Domain.ValueObjects.Percentual;

type
  TIndicadorSaudeService = class
  public
    class function ObterCor(const APercentual: TPercentual): string; static;
  end;

implementation

class function TIndicadorSaudeService.ObterCor(const APercentual: TPercentual): string;
begin
  if APercentual.Valor < 5 then
    Exit('Verde');

  if APercentual.Valor <= 10 then
    Exit('Amarelo');

  Result := 'Vermelho';
end;

end.
