unit uDmLoteAves;

interface

uses
  System.SysUtils, System.Classes,
  Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB;

type
  TdmLoteAves = class(TDataModule)
    conFirebird: TFDConnection;
    qryLoteAves: TFDQuery;
    qryPesagem: TFDQuery;
    qryMortalidade: TFDQuery;
    spInserirMortalidade: TFDStoredProc;
    spInserirPesagem: TFDStoredProc;
    dsLoteAves: TDataSource;
    dsPesagem: TDataSource;
    dsMortalidade: TDataSource;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  public
    procedure CarregarPesagens(const AIdLote: Integer);
    procedure CarregarMortalidades(const AIdLote: Integer);
  end;

var
  dmLoteAves: TdmLoteAves;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmLoteAves.DataModuleCreate(Sender: TObject);
begin
  conFirebird.LoginPrompt := False;
  conFirebird.Connected := False;
  conFirebird.Params.Clear;

  conFirebird.Params.Add('DriverID=FB');
  conFirebird.Params.Add('Server=localhost');
  conFirebird.Params.Add('Port=3050');
  conFirebird.Params.Add('Database=C:\firebird\avaliacaoaviario.fdb');
  conFirebird.Params.Add('User_Name=SYSDBA');
  conFirebird.Params.Add('Password=1234');
  conFirebird.Params.Add('CharacterSet=UTF8');

  conFirebird.Connected := True;

  qryLoteAves.Open;
end;

procedure TdmLoteAves.CarregarPesagens(const AIdLote: Integer);
begin
  qryPesagem.Close;
  qryPesagem.ParamByName('ID_LOTE').AsInteger := AIdLote;
  qryPesagem.Open;
end;

procedure TdmLoteAves.CarregarMortalidades(const AIdLote: Integer);
begin
  qryMortalidade.Close;
  qryMortalidade.ParamByName('ID_LOTE').AsInteger := AIdLote;
  qryMortalidade.Open;
end;

end.

