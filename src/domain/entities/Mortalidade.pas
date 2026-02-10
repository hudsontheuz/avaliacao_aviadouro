unit Domain.Entities.Mortalidade;

interface

uses
  System.SysUtils,
  Domain.ValueObjects.Percentual,
  Domain.Exceptions.DomainException;

type
  TMortalidade = class
  private
    FLoteId: Integer;
    FDataRegistro: TDateTime;
    FQuantidade: Integer;
    FPercentualAcumulado: TPercentual;
  public
    constructor Create(ALoteId, AQuantidade: Integer; ADataRegistro: TDateTime; APercentualAcumulado: Double);
    property LoteId: Integer read FLoteId;
    property DataRegistro: TDateTime read FDataRegistro;
    property Quantidade: Integer read FQuantidade;
    property PercentualAcumulado: TPercentual read FPercentualAcumulado;
  end;

implementation

constructor TMortalidade.Create(ALoteId, AQuantidade: Integer; ADataRegistro: TDateTime; APercentualAcumulado: Double);
begin
  if ALoteId <= 0 then
    raise EDomainException.Create('Lote inválido para mortalidade.');

  if AQuantidade <= 0 then
    raise EDomainException.Create('Quantidade de mortalidade deve ser maior que zero.');

  FLoteId := ALoteId;
  FQuantidade := AQuantidade;
  FDataRegistro := ADataRegistro;
  FPercentualAcumulado := TPercentual.De(APercentualAcumulado);
end;

end.
