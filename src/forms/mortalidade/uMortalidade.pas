unit uMortalidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TfrmMortalidade = class(TForm)
    pnlMortalidade: TPanel;
    dbgMortalidade: TDBGrid;
    ED_DATAMORTALIDADE: TDateTimePicker;
    ED_QUANTIDADEMORTA: TEdit;
    ED_OBSERVACAO: TEdit;
    btnSalvarMortalidade: TButton;
    lblDataMortalidade: TLabel;
    lblQuantidadeMorta: TLabel;
    lblObservacao: TLabel;
    GroupBox1: TGroupBox;
    pnlInidicador: TPanel;
    pnlVerde: TPanel;
    pnlAmarelo: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pnlIndicadorDeLote: TPanel;
    lkpLote: TDBLookupComboBox;
    lblLote: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ED_QUANTIDADEMORTAKeyPress(Sender: TObject; var Key: Char);
    procedure btnSalvarMortalidadeClick(Sender: TObject);
    procedure lkpLoteClick(Sender: TObject);
  private
    FIdLote: Integer;
    procedure LimparCampos;
    function LerQuantidadeMorta: Integer;
    function LerObservacao: string;
    procedure AtualizarIndicadorSaude(const PercentualMortalidade: Double);
    procedure CarregarGridMortalidade;
    function CalcularPercentualMortalidadeDoLote(const AIdLote: Integer): Double;
  public
  end;

var
  frmMortalidade: TfrmMortalidade;

implementation

uses
  uDmLoteAves, uMortalidadeDomain, FireDAC.Comp.Client;

{$R *.dfm}

procedure TfrmMortalidade.FormShow(Sender: TObject);
begin
  dbgMortalidade.DataSource := dmLoteAves.dsMortalidade;

  if not dmLoteAves.conFirebird.Connected then
    dmLoteAves.conFirebird.Connected := True;

  if not dmLoteAves.qryLoteAves.Active then
    dmLoteAves.qryLoteAves.Open;

  lkpLote.ListSource := dmLoteAves.dsLoteAves;
  lkpLote.ListField := 'ID_LOTE';
  lkpLote.KeyField := 'ID_LOTE';

  FIdLote := 0;
  lkpLote.KeyValue := Null;

  pnlInidicador.ParentBackground := False;
  pnlInidicador.Color := clBtnFace;
  pnlInidicador.Caption := '--';

  CarregarGridMortalidade;
  LimparCampos;
end;

procedure TfrmMortalidade.CarregarGridMortalidade;
begin
  dmLoteAves.qryMortalidade.Close;
  dmLoteAves.qryMortalidade.SQL.Text :=
    'SELECT ' +
    '  ID_MORTALIDADE, ' +
    '  ID_LOTE_FK, ' +
    '  DATA_MORTALIDADE, ' +
    '  QUANTIDADE_MORTA, ' +
    '  OBSERVACAO ' +
    'FROM TAB_MORTALIDADE ' +
    'ORDER BY DATA_MORTALIDADE DESC';
  dmLoteAves.qryMortalidade.Open;
end;

procedure TfrmMortalidade.LimparCampos;
begin
  ED_DATAMORTALIDADE.Date := Date;
  ED_QUANTIDADEMORTA.Clear;
  ED_OBSERVACAO.Clear;
  ED_QUANTIDADEMORTA.SetFocus;
end;

procedure TfrmMortalidade.lkpLoteClick(Sender: TObject);
var
  Perc: Double;
begin
  if VarIsNull(lkpLote.KeyValue) then
  begin
    FIdLote := 0;
    pnlInidicador.Color := clBtnFace;
    pnlInidicador.Caption := '--';
    Exit;
  end;

  FIdLote := VarAsType(lkpLote.KeyValue, varInteger);
  Perc := CalcularPercentualMortalidadeDoLote(FIdLote);
  AtualizarIndicadorSaude(Perc);
end;

procedure TfrmMortalidade.ED_QUANTIDADEMORTAKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key := #0;
end;

function TfrmMortalidade.LerQuantidadeMorta: Integer;
begin
  if Trim(ED_QUANTIDADEMORTA.Text) = '' then
    raise Exception.Create('Informe a QUANTIDADE_MORTA.');

  if not TryStrToInt(Trim(ED_QUANTIDADEMORTA.Text), Result) then
    raise Exception.Create('QUANTIDADE_MORTA inválida.');

  if Result <= 0 then
    raise Exception.Create('QUANTIDADE_MORTA deve ser maior que zero.');
end;

function TfrmMortalidade.LerObservacao: string;
begin
  Result := Trim(ED_OBSERVACAO.Text);
end;

procedure TfrmMortalidade.AtualizarIndicadorSaude(const PercentualMortalidade: Double);
begin
  pnlInidicador.ParentBackground := False;

  if PercentualMortalidade < 5 then
    pnlInidicador.Color := clGreen
  else if PercentualMortalidade <= 10 then
    pnlInidicador.Color := clYellow
  else
    pnlInidicador.Color := clRed;

  pnlInidicador.Caption := FormatFloat('0.00', PercentualMortalidade) + '%';
end;

function TfrmMortalidade.CalcularPercentualMortalidadeDoLote(const AIdLote: Integer): Double;
var
  Qry: TFDQuery;
  QtdInicial: Integer;
  TotalMorta: Integer;
begin
  Result := 0;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := dmLoteAves.conFirebird;

    Qry.SQL.Text := 'SELECT QUANTIDADE_INICIAL FROM TAB_LOTE_AVES WHERE ID_LOTE = :ID_LOTE';
    Qry.ParamByName('ID_LOTE').AsInteger := AIdLote;
    Qry.Open;
    if Qry.IsEmpty then
      Exit;

    QtdInicial := Qry.FieldByName('QUANTIDADE_INICIAL').AsInteger;
    Qry.Close;

    Qry.SQL.Text := 'SELECT COALESCE(SUM(QUANTIDADE_MORTA),0) AS TOTAL_MORTA FROM TAB_MORTALIDADE WHERE ID_LOTE_FK = :ID_LOTE';
    Qry.ParamByName('ID_LOTE').AsInteger := AIdLote;
    Qry.Open;

    TotalMorta := Qry.FieldByName('TOTAL_MORTA').AsInteger;

    if QtdInicial > 0 then
      Result := (TotalMorta / QtdInicial) * 100
    else
      Result := 0;
  finally
    Qry.Free;
  end;
end;

procedure TfrmMortalidade.btnSalvarMortalidadeClick(Sender: TObject);
var
  Qtd: Integer;
  Mort: TMortalidade;
  Perc: Double;
begin
  try
    if FIdLote <= 0 then
      raise Exception.Create('Selecione um lote.');

    Qtd := LerQuantidadeMorta;

    Mort := TMortalidade.Create(FIdLote, ED_DATAMORTALIDADE.Date, Qtd, LerObservacao);
    try
      Mort.Validar;

      dmLoteAves.spInserirMortalidade.Close;
      dmLoteAves.spInserirMortalidade.StoredProcName := 'PRCD_INSERIR_MORTALIDADE';
      dmLoteAves.spInserirMortalidade.Params.Clear;

      dmLoteAves.spInserirMortalidade.Params.Add('P_ID_LOTE', ftInteger).AsInteger := Mort.IdLote;
      dmLoteAves.spInserirMortalidade.Params.Add('P_DATA_MORTALIDADE', ftDate).AsDate := Mort.DataMortalidade;
      dmLoteAves.spInserirMortalidade.Params.Add('P_QUANTIDADE_MORTA', ftInteger).AsInteger := Mort.QuantidadeMorta;
      dmLoteAves.spInserirMortalidade.Params.Add('P_OBSERVACAO', ftString).AsString := Mort.Observacao;

      dmLoteAves.spInserirMortalidade.ExecProc;
    finally
      Mort.Free;
    end;

    dmLoteAves.qryMortalidade.Close;
    dmLoteAves.qryMortalidade.Open;

    Perc := CalcularPercentualMortalidadeDoLote(FIdLote);
    AtualizarIndicadorSaude(Perc);

    MessageDlg('Mortalidade salva com sucesso!', mtInformation, [mbOK], 0);
    LimparCampos;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

end.

