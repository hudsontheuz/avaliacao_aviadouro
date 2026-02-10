unit Pesagem;

interface

uses
  SysUtils,
  DomainException;

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

constructor TPesagem.Create(AIdLote: Integer; ADataPesagem: TDate; AQuantidadePesada: Integer; APesoMedio: Double);
begin
  if AIdLote <= 0 then
    raise EDomainException.Create('Lote da pesagem deve ser informado.');

  if AQuantidadePesada <= 0 then
    raise EDomainException.Create('Quantidade pesada deve ser maior que zero.');

  if APesoMedio <= 0 then
    raise EDomainException.Create('Peso medio deve ser maior que zero.');

  FIdLote := AIdLote;
  FDataPesagem := ADataPesagem;
  FQuantidadePesada := AQuantidadePesada;
  FPesoMedio := APesoMedio;
end;

end.
