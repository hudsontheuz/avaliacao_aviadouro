unit Application.DTO.RegistrarPesagemDTO;

interface

uses
  System.SysUtils;

type
  TRegistrarPesagemDTO = record
    LoteId: Integer;
    QuantidadePesada: Integer;
    PesoMedio: Double;
    DataPesagem: TDateTime;
  end;

implementation

end.
