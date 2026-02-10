unit RegistrarPesagemDTO;

interface

uses
  SysUtils;

type
  TRegistrarPesagemDTO = record
    IdLote: Integer;
    DataPesagem: TDate;
    QuantidadePesada: Integer;
    PesoMedio: Double;
  end;

implementation

end.
