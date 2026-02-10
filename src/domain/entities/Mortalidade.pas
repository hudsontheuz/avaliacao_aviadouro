unit Mortalidade;

interface

uses
  SysUtils,
  DomainException;

type
  TMortalidade = class
  private
    FIdLote: Integer;
    FDataMortalidade: TDate;
    FQuantidadeMorta: Integer;
  public
    constructor Create(AIdLote: Integer; ADataMortalidade: TDate; AQuantidadeMorta: Integer);

    property IdLote: Integer read FIdLote;
    property DataMortalidade: TDate read FDataMortalidade;
    property QuantidadeMorta: Integer read FQuantidadeMorta;
  end;

implementation

constructor TMortalidade.Create(AIdLote: Integer; ADataMortalidade: TDate; AQuantidadeMorta: Integer);
begin
  if AIdLote <= 0 then
    raise EDomainException.Create('Lote da mortalidade deve ser informado.');

  if AQuantidadeMorta <= 0 then
    raise EDomainException.Create('Quantidade morta deve ser maior que zero.');

  FIdLote := AIdLote;
  FDataMortalidade := ADataMortalidade;
  FQuantidadeMorta := AQuantidadeMorta;
end;

end.
