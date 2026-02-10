unit Infrastructure.Persistence.FirebirdConnectionFactory;

interface

uses
  FireDAC.Comp.Client;

type
  TFirebirdConnectionFactory = class
  public
    class function Criar: TFDConnection; static;
  end;

implementation

class function TFirebirdConnectionFactory.Criar: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.DriverName := 'FB';
  Result.Params.Values['Server'] := 'localhost';
  Result.Params.Values['User_Name'] := 'SYSDBA';
  Result.LoginPrompt := False;
end;

end.
