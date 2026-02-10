unit domain.entities.Pesagem;

interface

uses
  SysUtils;

type
  TPesagem = class
  private
    FIdLote: Integer;
    FDataPesagem: TDate;
    FQuantidadePesada: Integer;
    FPesoMedio: Double;
  public
    constructor Create(AIdLote: Integer; ADataPesagem: TDate; AQuantidadePesada: Integer; APesoMedio: Double);

    property IdLote: Integer read FIdLote;
    property DataPesagem: TDate read FDataPesagem;
    property QuantidadePesada: Integer read FQuantidadePesada;
    property PesoMedio: Double read FPesoMedio;
  end;

implementation

uses
  domain.exceptions.DomainException;

constructor TPesagem.Create(AIdLote: Integer; ADataPesagem: TDate;
  AQuantidadePesada: Integer; APesoMedio: Double);
begin
  if AIdLote <= 0 then
    raise EDomainException.Create('Lote inválido para pesagem.');

  if AQuantidadePesada <= 0 then
    raise EDomainException.Create('Quantidade pesada deve ser maior que zero.');

  if APesoMedio <= 0 then
    raise EDomainException.Create('Peso médio deve ser maior que zero.');

  FIdLote := AIdLote;
  FDataPesagem := ADataPesagem;
  FQuantidadePesada := AQuantidadePesada;
  FPesoMedio := APesoMedio;
end;

end.
