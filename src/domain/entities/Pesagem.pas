unit Domain.Entities.Pesagem;

interface

uses
  System.SysUtils,
  Domain.Exceptions.DomainException;

type
  TPesagem = class
  private
    FLoteId: Integer;
    FDataPesagem: TDateTime;
    FQuantidadePesada: Integer;
    FPesoMedio: Double;
  public
    constructor Create(ALoteId, AQuantidadePesada: Integer; APesoMedio: Double; ADataPesagem: TDateTime);
    property LoteId: Integer read FLoteId;
    property DataPesagem: TDateTime read FDataPesagem;
    property QuantidadePesada: Integer read FQuantidadePesada;
    property PesoMedio: Double read FPesoMedio;
  end;

implementation

constructor TPesagem.Create(ALoteId, AQuantidadePesada: Integer; APesoMedio: Double; ADataPesagem: TDateTime);
begin
  if ALoteId <= 0 then
    raise EDomainException.Create('Lote inválido para pesagem.');

  if AQuantidadePesada <= 0 then
    raise EDomainException.Create('Quantidade pesada deve ser maior que zero.');

  if APesoMedio <= 0 then
    raise EDomainException.Create('Peso médio deve ser maior que zero.');

  FLoteId := ALoteId;
  FQuantidadePesada := AQuantidadePesada;
  FPesoMedio := APesoMedio;
  FDataPesagem := ADataPesagem;
end;

end.
