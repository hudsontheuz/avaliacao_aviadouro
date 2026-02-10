unit IndicadorSaudeService;

interface

uses
  Percentual;

type
  TFaixaSaude = (fsVerde, fsAmarela, fsVermelha);

  TIndicadorSaudeService = class
  public
    class function ObterFaixa(APercentualMortalidade: TPercentual): TFaixaSaude; static;
  end;

implementation

class function TIndicadorSaudeService.ObterFaixa(APercentualMortalidade: TPercentual): TFaixaSaude;
var
  LValor: Double;
begin
  LValor := APercentualMortalidade.Valor;

  if LValor < 5 then
    Exit(fsVerde);

  if LValor <= 10 then
    Exit(fsAmarela);

  Result := fsVermelha;
end;

end.
