unit uControleLotes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, FireDAC.Comp.Client;

type
  TfrmControleLotes = class(TForm)
    pnlControleLotes: TPanel;
    gbControleLotes: TGroupBox;
    lkpLote: TDBLookupComboBox;
    lblID: TLabel;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure lkpLoteClick(Sender: TObject);
  private
    FQryControleLotes: TFDQuery;
    FDSControleLotes: TDataSource;
    procedure PrepararLookup;
    procedure PrepararGrid;
    procedure CarregarDadosDoLote(const AId: Integer);
  public
  end;

var
  frmControleLotes: TfrmControleLotes;

implementation

uses
  uDmLoteAves;

{$R *.dfm}

procedure TfrmControleLotes.FormShow(Sender: TObject);
begin
  if not dmLoteAves.conFirebird.Connected then
    dmLoteAves.conFirebird.Connected := True;

  if not dmLoteAves.qryLoteAves.Active then
    dmLoteAves.qryLoteAves.Open;

  PrepararLookup;
  PrepararGrid;

  lkpLote.KeyValue := Null;
end;

procedure TfrmControleLotes.PrepararLookup;
begin
  lkpLote.ListSource := dmLoteAves.dsLoteAves;
  lkpLote.ListField := 'ID_LOTE';
  lkpLote.KeyField := 'ID_LOTE';
end;

procedure TfrmControleLotes.PrepararGrid;
begin
  if not Assigned(FQryControleLotes) then
  begin
    FQryControleLotes := TFDQuery.Create(Self);
    FQryControleLotes.Connection := dmLoteAves.conFirebird;
  end;

  if not Assigned(FDSControleLotes) then
  begin
    FDSControleLotes := TDataSource.Create(Self);
    FDSControleLotes.DataSet := FQryControleLotes;
  end;

  DBGrid1.DataSource := FDSControleLotes;

  FQryControleLotes.Close;
  FQryControleLotes.SQL.Text :=
    'SELECT ' + sLineBreak +
    '  L.ID_LOTE, ' + sLineBreak +
    '  L.DESCRICAO, ' + sLineBreak +
    '  L.QUANTIDADE_INICIAL, ' + sLineBreak +
    '  COALESCE(P.TOTAL_PESADO, 0) AS TOTAL_PESADO, ' + sLineBreak +
    '  COALESCE(M.TOTAL_MORTO, 0) AS TOTAL_MORTO, ' + sLineBreak +
    '  (L.QUANTIDADE_INICIAL - (COALESCE(P.TOTAL_PESADO, 0) + COALESCE(M.TOTAL_MORTO, 0))) AS RESTANTES, ' + sLineBreak +
    '  ROUND((COALESCE(M.TOTAL_MORTO, 0) * 100.0) / NULLIF(L.QUANTIDADE_INICIAL, 0), 2) AS PERCENTUAL_MORTALIDADE ' + sLineBreak +
    'FROM TAB_LOTE_AVES L ' + sLineBreak +
    'LEFT JOIN ( ' + sLineBreak +
    '  SELECT ID_LOTE_FK, SUM(QUANTIDADE_PESADA) AS TOTAL_PESADO ' + sLineBreak +
    '  FROM TAB_PESAGEM ' + sLineBreak +
    '  GROUP BY ID_LOTE_FK ' + sLineBreak +
    ') P ON P.ID_LOTE_FK = L.ID_LOTE ' + sLineBreak +
    'LEFT JOIN ( ' + sLineBreak +
    '  SELECT ID_LOTE_FK, SUM(QUANTIDADE_MORTA) AS TOTAL_MORTO ' + sLineBreak +
    '  FROM TAB_MORTALIDADE ' + sLineBreak +
    '  GROUP BY ID_LOTE_FK ' + sLineBreak +
    ') M ON M.ID_LOTE_FK = L.ID_LOTE ' + sLineBreak +
    'WHERE L.ID_LOTE = :ID ' + sLineBreak +
    'ORDER BY L.ID_LOTE';

end;

procedure TfrmControleLotes.CarregarDadosDoLote(const AId: Integer);
begin
  if not Assigned(FQryControleLotes) then
    Exit;

  FQryControleLotes.Close;
  FQryControleLotes.ParamByName('ID').AsInteger := AId;
  FQryControleLotes.Open;
end;

procedure TfrmControleLotes.lkpLoteClick(Sender: TObject);
var
  Id: Integer;
begin
  if VarIsNull(lkpLote.KeyValue) then
  begin
    if Assigned(FQryControleLotes) then
      FQryControleLotes.Close;
    Exit;
  end;

  Id := VarAsType(lkpLote.KeyValue, varInteger);
  CarregarDadosDoLote(Id);
end;

end.

