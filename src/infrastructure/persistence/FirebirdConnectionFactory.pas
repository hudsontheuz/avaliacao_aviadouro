unit infrastructure.persistence.FirebirdConnectionFactory;

interface

uses
  FireDAC.Comp.Client;

type
  TFirebirdConnectionFactory = class
  public
    class function CriarConexao: TFDConnection; static;
  end;

implementation

class function TFirebirdConnectionFactory.CriarConexao: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.LoginPrompt := False;
  Result.Params.Values['DriverID'] := 'FB';
  Result.Params.Values['Server'] := 'localhost';
  Result.Params.Values['Port'] := '3050';
  Result.Params.Values['Database'] := 'C:\firebird\avaliacaoaviario.fdb';
  Result.Params.Values['User_Name'] := 'SYSDBA';
  Result.Params.Values['Password'] := '1234';
  Result.Params.Values['CharacterSet'] := 'UTF8';
end;

end.
