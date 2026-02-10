unit domain.entities.Mortalidade;

interface

uses
  SysUtils;

type
  TMortalidade = class
  private
    FIdLote: Integer;
    FDataMortalidade: TDate;
    FQuantidadeMorta: Integer;
    FObservacao: string;
  public
    constructor Create(AIdLote: Integer; ADataMortalidade: TDate; AQuantidadeMorta: Integer; const AObservacao: string);

    property IdLote: Integer read FIdLote;
    property DataMortalidade: TDate read FDataMortalidade;
    property QuantidadeMorta: Integer read FQuantidadeMorta;
    property Observacao: string read FObservacao;
  end;

implementation

uses
  domain.exceptions.DomainException;

constructor TMortalidade.Create(AIdLote: Integer; ADataMortalidade: TDate;
  AQuantidadeMorta: Integer; const AObservacao: string);
begin
  if AIdLote <= 0 then
    raise EDomainException.Create('Lote inválido para mortalidade.');

  if AQuantidadeMorta <= 0 then
    raise EDomainException.Create('Quantidade morta deve ser maior que zero.');

  FIdLote := AIdLote;
  FDataMortalidade := ADataMortalidade;
  FQuantidadeMorta := AQuantidadeMorta;
  FObservacao := AObservacao;
end;

end.
