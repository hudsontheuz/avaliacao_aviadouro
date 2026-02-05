unit uLoteAves;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmLoteAves = class(TForm)
    dbgLoteAves: TDBGrid;
    pnlLoteAves: TPanel;
    pnlCadastroLote: TPanel;
    ED_DESCRICAO: TEdit;
    lblDescricao: TLabel;
    lblQuantidadeInicial: TLabel;
    lblDataEntrada: TLabel;
    btnSalvarLote: TButton;
    btnNovoLote: TButton;
    lblID: TLabel;
    ED_ID: TEdit;
    ED_QUANTIDADE_INICIAL: TEdit;
    ED_DATAENTRADA: TDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure btnNovoLoteClick(Sender: TObject);
    procedure btnSalvarLoteClick(Sender: TObject);
    procedure ED_QUANTIDADE_INICIALKeyPress(Sender: TObject; var Key: Char);
  private
    procedure LimparCampos;
    function ValidarCampos(out AMsg: string; out AQtd: Integer): Boolean;
  public
  end;

var
  frmLoteAves: TfrmLoteAves;

implementation

uses
  uDmLoteAves, uLoteAvesDomain, FireDAC.Stan.Param;

{$R *.dfm}

procedure TfrmLoteAves.FormShow(Sender: TObject);
begin
  dbgLoteAves.DataSource := dmLoteAves.dsLoteAves;

  if not dmLoteAves.conFirebird.Connected then
    dmLoteAves.conFirebird.Connected := True;

  if not dmLoteAves.qryLoteAves.Active then
    dmLoteAves.qryLoteAves.Open;
end;

procedure TfrmLoteAves.LimparCampos;
begin
  ED_ID.Clear;
  ED_DESCRICAO.Clear;
  ED_QUANTIDADE_INICIAL.Clear;
  ED_DATAENTRADA.Date := Date;
  ED_DESCRICAO.SetFocus;
end;

function TfrmLoteAves.ValidarCampos(out AMsg: string; out AQtd: Integer): Boolean;
begin
  AMsg := '';
  AQtd := 0;

  if Trim(ED_DESCRICAO.Text) = '' then
  begin
    AMsg := 'Informe a DESCRICAO.';
    Exit(False);
  end;

  if Trim(ED_QUANTIDADE_INICIAL.Text) = '' then
  begin
    AMsg := 'Informe a QUANTIDADE_INICIAL.';
    Exit(False);
  end;

  if not TryStrToInt(Trim(ED_QUANTIDADE_INICIAL.Text), AQtd) then
  begin
    AMsg := 'QUANTIDADE_INICIAL inválida. Use apenas números.';
    Exit(False);
  end;

  if AQtd <= 0 then
  begin
    AMsg := 'QUANTIDADE_INICIAL deve ser maior que zero.';
    Exit(False);
  end;

  Result := True;
end;

procedure TfrmLoteAves.btnNovoLoteClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TfrmLoteAves.btnSalvarLoteClick(Sender: TObject);
var
  Msg: string;
  Qtd: Integer;
  Params: TFDParams;
begin
  if not ValidarCampos(Msg, Qtd) then
  begin
    MessageDlg(Msg, mtWarning, [mbOK], 0);
    Exit;
  end;

  Params := TFDParams.Create;
  try
    Params.Add('DESCRICAO', ftString).AsString := Trim(ED_DESCRICAO.Text);
    Params.Add('DATA_ENTRADA', ftDate).AsDate := ED_DATAENTRADA.Date;
    Params.Add('QUANTIDADE_INICIAL', ftInteger).AsInteger := Qtd;

    dmLoteAves.conFirebird.ExecSQL(
      'INSERT INTO TAB_LOTE_AVES (ID_LOTE, DESCRICAO, DATA_ENTRADA, QUANTIDADE_INICIAL, PESO_MEDIO_GERAL) ' +
      'VALUES (NEXT VALUE FOR SEQ_LOTE_AVES, :DESCRICAO, :DATA_ENTRADA, :QUANTIDADE_INICIAL, NULL)',
      Params
    );

    dmLoteAves.qryLoteAves.Close;
    dmLoteAves.qryLoteAves.Open;

    MessageDlg('Lote salvo com sucesso!', mtInformation, [mbOK], 0);
    LimparCampos;
  except
    on E: Exception do
      MessageDlg('Erro ao salvar lote: ' + E.Message, mtError, [mbOK], 0);
  end;

  Params.Free;
end;


procedure TfrmLoteAves.ED_QUANTIDADE_INICIALKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key := #0;
end;

end.

