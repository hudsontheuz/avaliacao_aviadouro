unit Lote;

interface

uses
  SysUtils,
  DomainException,
  Percentual;

type
  TLote = class
  private
    FId: Integer;
    FDescricao: string;
    FQuantidadeInicial: Integer;
    FPesoMedioAtual: Double;
  public
    constructor Create(AId: Integer; const ADescricao: string; AQuantidadeInicial: Integer);
    procedure AtualizarPesoMedio(APesoMedioAtual: Double);
    function CalcularPercentualMortalidade(ATotalMortes: Integer): TPercentual;

    property Id: Integer read FId;
    property Descricao: string read FDescricao;
    property QuantidadeInicial: Integer read FQuantidadeInicial;
    property PesoMedioAtual: Double read FPesoMedioAtual;
  end;

implementation

constructor TLote.Create(AId: Integer; const ADescricao: string; AQuantidadeInicial: Integer);
begin
  if AId <= 0 then
    raise EDomainException.Create('Id do lote deve ser maior que zero.');

  if Trim(ADescricao) = '' then
    raise EDomainException.Create('Descricao do lote e obrigatoria.');

  if AQuantidadeInicial <= 0 then
    raise EDomainException.Create('Quantidade inicial deve ser maior que zero.');

  FId := AId;
  FDescricao := ADescricao;
  FQuantidadeInicial := AQuantidadeInicial;
end;

procedure TLote.AtualizarPesoMedio(APesoMedioAtual: Double);
begin
  if APesoMedioAtual <= 0 then
    raise EDomainException.Create('Peso medio deve ser maior que zero.');

  FPesoMedioAtual := APesoMedioAtual;
end;

function TLote.CalcularPercentualMortalidade(ATotalMortes: Integer): TPercentual;
var
  LPercentual: Double;
begin
  if ATotalMortes < 0 then
    raise EDomainException.Create('Total de mortes nao pode ser negativo.');

  LPercentual := (ATotalMortes / FQuantidadeInicial) * 100;
  Result := TPercentual.Criar(LPercentual);
end;

end.
