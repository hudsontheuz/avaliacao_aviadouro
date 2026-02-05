unit uMortalidadeDomain;

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
    constructor Create(AIdLote: Integer; AData: TDate; AQtd: Integer; AObs: string);
    procedure Validar;

    property IdLote: Integer read FIdLote;
    property DataMortalidade: TDate read FDataMortalidade;
    property QuantidadeMorta: Integer read FQuantidadeMorta;
    property Observacao: string read FObservacao;
  end;

implementation

constructor TMortalidade.Create(AIdLote: Integer; AData: TDate; AQtd: Integer; AObs: string);
begin
  FIdLote := AIdLote;
  FDataMortalidade := AData;
  FQuantidadeMorta := AQtd;
  FObservacao := AObs;
end;

procedure TMortalidade.Validar;
begin
  if FIdLote <= 0 then
    raise Exception.Create('Lote inválido.');

  if FQuantidadeMorta <= 0 then
    raise Exception.Create('Quantidade inválida.');
end;

end.

