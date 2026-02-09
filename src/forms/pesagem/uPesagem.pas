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
    function LerPesoMedio: Double;
    procedure CarregarGridPesagem(const AIdLote: Integer);
  public
  end;

var
  frmPesagem: TfrmPesagem;

implementation

uses
  uDmLoteAves, uPesagemDomain, bib, FireDAC.Stan.Param;

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

  LimparCampos;
end;

procedure TfrmPesagem.CarregarGridPesagem(const AIdLote: Integer);
begin
  dmLoteAves.qryPesagem.Close;
  dmLoteAves.qryPesagem.SQL.Text :=
    'SELECT ' +
    '  ID_PESAGEM, ' +
    '  ID_LOTE_FK, ' +
    '  DATA_PESAGEM, ' +
    '  PESO_MEDIO, ' +
    '  QUANTIDADE_PESADA ' +
    'FROM TAB_PESAGEM ' +
    'WHERE ID_LOTE_FK = :ID_LOTE ' +
    'ORDER BY DATA_PESAGEM DESC, ID_PESAGEM DESC';
  dmLoteAves.qryPesagem.ParamByName('ID_LOTE').AsInteger := AIdLote;
  dmLoteAves.qryPesagem.Open;
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
  begin
    FIdLote := 0;
    dmLoteAves.qryPesagem.Close;
    Exit;
  end;

  FIdLote := VarAsType(lkpLote.KeyValue, varInteger);
  CarregarGridPesagem(FIdLote);
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

function TfrmPesagem.LerPesoMedio: Double;
var
  Texto: string;
  Fs: TFormatSettings;
begin
  if Trim(ED_PESOMEDIO.Text) = '' then
    raise Exception.Create('Informe o PESO_MEDIO.');

  Texto := Trim(ED_PESOMEDIO.Text);
  Fs := FormatSettings;

  if not TryStrToFloat(Texto, Result, Fs) then
  begin
    Texto := StringReplace(Texto, ',', '.', [rfReplaceAll]);
    Fs.DecimalSeparator := '.';
    if not TryStrToFloat(Texto, Result, Fs) then
      raise Exception.Create('PESO_MEDIO inválido.');
  end;

  if Result <= 0 then
    raise Exception.Create('PESO_MEDIO deve ser maior que zero.');
end;

procedure TfrmPesagem.btnSalvarPesagemClick(Sender: TObject);
var
  Qtd: Integer;
  Peso: Double;
  Pesagem: TPesagem;
begin
  try
    bib.ValidarLoteSelecionado(FIdLote);

    Qtd := LerQuantidadePesada;
    Peso := LerPesoMedio;

    Pesagem := TPesagem.Create(FIdLote, EB_DATAPESAGEM.Date, Peso, Qtd);
    try
      Pesagem.Validar;

      dmLoteAves.spInserirPesagem.Close;
      dmLoteAves.spInserirPesagem.Unprepare;
      dmLoteAves.spInserirPesagem.StoredProcName := 'PRCD_INSERIR_PESAGEM';
      dmLoteAves.spInserirPesagem.Prepare;

      dmLoteAves.spInserirPesagem.ParamByName('P_ID_LOTE').AsInteger := Pesagem.IdLote;
      dmLoteAves.spInserirPesagem.ParamByName('P_DATA_PESAGEM').AsDate := Pesagem.DataPesagem;
      dmLoteAves.spInserirPesagem.ParamByName('P_PESO_MEDIO').Value := Currency(Pesagem.PesoMedio);
      dmLoteAves.spInserirPesagem.ParamByName('P_QUANTIDADE_PESADA').AsInteger := Pesagem.QuantidadePesada;

      dmLoteAves.spInserirPesagem.ExecProc;

      if FIdLote > 0 then
        CarregarGridPesagem(FIdLote)
      else
      begin
        dmLoteAves.qryPesagem.Close;
        dmLoteAves.qryPesagem.Open;
      end;

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
  bib.SomenteNumeros(Key);
end;

procedure TfrmPesagem.ED_PESOMEDIOKeyPress(Sender: TObject; var Key: Char);
begin
  bib.SomenteNumerosEVirgula(Key);
end;

end.

