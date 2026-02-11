unit Domain.ValueObjects.Percentual;

interface

uses
  Domain.Exceptions.DomainException;

type
  TPercentual = record
  private
    FValor: Double;
  public
    class function De(AValor: Double): TPercentual; static;
    property Valor: Double read FValor;
  end;

implementation

class function TPercentual.De(AValor: Double): TPercentual;
begin
  if (AValor < 0) or (AValor > 100) then
    raise EDomainException.Create('Percentual deve estar entre 0 e 100.');

  Result.FValor := AValor;
end;

end.
