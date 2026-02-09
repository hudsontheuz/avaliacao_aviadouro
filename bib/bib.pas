unit bib;

interface

uses
  System.SysUtils;

procedure SomenteNumerosEVirgula(var Key: Char);
procedure SomenteNumeros(var Key: Char);
procedure ValidarLoteSelecionado(const AIdLote: Integer);

implementation

procedure SomenteNumerosEVirgula(var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, ',', '.']) then
    Key := #0;
end;

procedure SomenteNumeros(var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key := #0;
end;

procedure ValidarLoteSelecionado(const AIdLote: Integer);
begin
  if AIdLote <= 0 then
    raise Exception.Create('Selecione um lote.');
end;

end.
