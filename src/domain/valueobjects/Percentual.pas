unit domain.valueobjects.Percentual;

interface

uses
  domain.exceptions.DomainException;

type
  TPercentual = record
  private
    FValor: Double;
  public
    class function Criar(AValor: Double): TPercentual; static;
    property Valor: Double read FValor;
  end;

implementation

class function TPercentual.Criar(AValor: Double): TPercentual;
begin
  if (AValor < 0) or (AValor > 100) then
    raise EDomainException.Create('Percentual deve estar entre 0 e 100.');

  Result.FValor := AValor;
end;

end.
