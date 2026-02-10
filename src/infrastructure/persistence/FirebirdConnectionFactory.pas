unit FirebirdConnectionFactory;

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
  Result.Params.DriverID := 'FB';
  Result.LoginPrompt := False;
  // Exemplo: setar Database, User_Name e Password via configuração externa.
end;

end.
