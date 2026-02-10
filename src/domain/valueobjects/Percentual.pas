unit Percentual;

interface

uses
  DomainException;

type
  TPercentual = record
  private
    FValor: Double;
  public
    class function Criar(AValor: Double): TPercentual; static;
    function Valor: Double;
  end;

implementation

class function TPercentual.Criar(AValor: Double): TPercentual;
begin
  if (AValor < 0) or (AValor > 100) then
    raise EDomainException.Create('Percentual deve estar entre 0 e 100.');

  Result.FValor := AValor;
end;

function TPercentual.Valor: Double;
begin
  Result := FValor;
end;

end.
