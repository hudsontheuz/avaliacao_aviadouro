unit Application.DTO.RegistrarMortalidadeDTO;

interface

uses
  System.SysUtils;

type
  TRegistrarMortalidadeDTO = record
    LoteId: Integer;
    Quantidade: Integer;
    DataRegistro: TDateTime;
  end;

implementation

end.
