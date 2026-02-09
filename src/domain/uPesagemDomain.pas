unit uPesagemDomain;

interface

uses
  SysUtils;

type
  TPesagem = class
  private
    FIdLote: Integer;
    FDataPesagem: TDate;
    FPesoMedio: Double;
    FQuantidadePesada: Integer;
  public
    constructor Create(AIdLote: Integer; AData: TDate; APesoMedio: Double; AQtd: Integer);
    procedure Validar;

    property IdLote: Integer read FIdLote;
    property DataPesagem: TDate read FDataPesagem;
    property PesoMedio: Double read FPesoMedio;
    property QuantidadePesada: Integer read FQuantidadePesada;
  end;

implementation

constructor TPesagem.Create(AIdLote: Integer; AData: TDate; APesoMedio: Double; AQtd: Integer);
begin
  FIdLote := AIdLote;
  FDataPesagem := AData;
  FPesoMedio := APesoMedio;
  FQuantidadePesada := AQtd;
end;

procedure TPesagem.Validar;
begin
  if FIdLote <= 0 then
    raise Exception.Create('Lote inválido.');

  if FQuantidadePesada <= 0 then
    raise Exception.Create('Quantidade inválida.');

  if FPesoMedio <= 0 then
    raise Exception.Create('Peso médio inválido.');
end;

end.

