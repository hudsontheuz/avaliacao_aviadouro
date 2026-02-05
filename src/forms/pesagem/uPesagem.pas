unit uPesagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TfrmPesagem = class(TForm)
    Panel1: TPanel;
    dbgPesagem: TDBGrid;
    pnlPesagem: TPanel;
    EB_DATAPESAGEM: TDateTimePicker;
    ED_PESOMEDIO: TEdit;
    ED_QUANTIDADEPESADA: TEdit;
    lblDataPesagem: TLabel;
    lblQuantidadePesada: TLabel;
    lblPesoMedio: TLabel;
    btnSalvarPesagem: TButton;
    pnlLote: TPanel;
    lkpLote: TDBLookupComboBox;
    lblLote: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarPesagemClick(Sender: TObject);
    procedure ED_QUANTIDADEPESADAKeyPress(Sender: TObject; var Key: Char);
    procedure ED_PESOMEDIOKeyPress(Sender: TObject; var Key: Char);
    procedure lkpLoteClick(Sender: TObject);
  private
    FIdLote: Integer;
    procedure LimparCampos;
    function LerQuantidadePesada: Integer;
    function LerPesoMedio: Integer;
  public
  end;

var
  frmPesagem: TfrmPesagem;

implementation

uses
  uDmLoteAves, uPesagemDomain, FireDAC.Stan.Param;

{$R *.dfm}

procedure TfrmPesagem.FormShow(Sender: TObject);
begin
  dbgPesagem.DataSource := dmLoteAves.dsPesagem;

  if not dmLoteAves.conFirebird.Connected then
    dmLoteAves.conFirebird.Connected := True;

  if not dmLoteAves.qryLoteAves.Active then
    dmLoteAves.qryLoteAves.Open;

  lkpLote.ListSource := dmLoteAves.dsLoteAves;
  lkpLote.ListField := 'ID_LOTE';
  lkpLote.KeyField := 'ID_LOTE';

  FIdLote := 0;
  lkpLote.KeyValue := Null;

  dmLoteAves.qryPesagem.Close;
  dmLoteAves.qryPesagem.SQL.Text :=
    'SELECT ' +
    '  ID_PESAGEM, ' +
    '  ID_LOTE_FK, ' +
    '  DATA_PESAGEM, ' +
    '  PESO_MEDIO, ' +
    '  QUANTIDADE_PESADA ' +
    'FROM TAB_PESAGEM ' +
    'ORDER BY DATA_PESAGEM DESC';
  dmLoteAves.qryPesagem.Open;

  LimparCampos;
end;

procedure TfrmPesagem.LimparCampos;
begin
  EB_DATAPESAGEM.Date := Date;
  ED_QUANTIDADEPESADA.Clear;
  ED_PESOMEDIO.Clear;
  ED_QUANTIDADEPESADA.SetFocus;
end;

procedure TfrmPesagem.lkpLoteClick(Sender: TObject);
begin
  if VarIsNull(lkpLote.KeyValue) then
    FIdLote := 0
  else
    FIdLote := VarAsType(lkpLote.KeyValue, varInteger);
end;

function TfrmPesagem.LerQuantidadePesada: Integer;
begin
  if Trim(ED_QUANTIDADEPESADA.Text) = '' then
    raise Exception.Create('Informe a QUANTIDADE_PESADA.');

  if not TryStrToInt(Trim(ED_QUANTIDADEPESADA.Text), Result) then
    raise Exception.Create('QUANTIDADE_PESADA inválida.');

  if Result <= 0 then
    raise Exception.Create('QUANTIDADE_PESADA deve ser maior que zero.');
end;

function TfrmPesagem.LerPesoMedio: Integer;
begin
  if Trim(ED_PESOMEDIO.Text) = '' then
    raise Exception.Create('Informe o PESO_MEDIO.');

  if not TryStrToInt(Trim(ED_PESOMEDIO.Text), Result) then
    raise Exception.Create('PESO_MEDIO inválido (use inteiro).');

  if Result <= 0 then
    raise Exception.Create('PESO_MEDIO deve ser maior que zero.');
end;

procedure TfrmPesagem.btnSalvarPesagemClick(Sender: TObject);
var
  Qtd: Integer;
  Peso: Integer;
  Pesagem: TPesagem;
begin
  try
    if FIdLote <= 0 then
      raise Exception.Create('Selecione um lote.');

    Qtd := LerQuantidadePesada;
    Peso := LerPesoMedio;

    Pesagem := TPesagem.Create(FIdLote, EB_DATAPESAGEM.Date, Peso, Qtd);
    try
      Pesagem.Validar;

      dmLoteAves.spInserirPesagem.Close;
      dmLoteAves.spInserirPesagem.StoredProcName := 'PRCD_INSERIR_PESAGEM';
      dmLoteAves.spInserirPesagem.Params.Clear;

      dmLoteAves.spInserirPesagem.Params.Add('P_ID_LOTE', ftInteger).AsInteger := Pesagem.IdLote;
      dmLoteAves.spInserirPesagem.Params.Add('P_DATA_PESAGEM', ftDate).AsDate := Pesagem.DataPesagem;
      dmLoteAves.spInserirPesagem.Params.Add('P_PESO_MEDIO', ftInteger).AsInteger := Pesagem.PesoMedio;
      dmLoteAves.spInserirPesagem.Params.Add('P_QUANTIDADE_PESADA', ftInteger).AsInteger := Pesagem.QuantidadePesada;

      dmLoteAves.spInserirPesagem.ExecProc;

      dmLoteAves.qryPesagem.Close;
      dmLoteAves.qryPesagem.Open;

      MessageDlg('Pesagem salva com sucesso!', mtInformation, [mbOK], 0);
      LimparCampos;
    finally
      Pesagem.Free;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmPesagem.ED_QUANTIDADEPESADAKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmPesagem.ED_PESOMEDIOKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key := #0;
end;

end.

