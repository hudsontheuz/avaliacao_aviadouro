unit Domain.Entities.Lote;

interface

uses
  System.SysUtils,
  Domain.Entities.Pesagem,
  Domain.Entities.Mortalidade,
  Domain.ValueObjects.Percentual,
  Domain.Exceptions.DomainException;

type
  TLote = class
  private
    FId: Integer;
    FDescricao: string;
    FDataEntrada: TDateTime;
    FQuantidadeInicial: Integer;
    FPesoMedioGeral: Double;
    FTotalMortalidade: Integer;
    FPercentualMortalidade: TPercentual;
  public
    constructor Create(AId: Integer; const ADescricao: string; ADataEntrada: TDateTime; AQuantidadeInicial: Integer);
    procedure AplicarPesagem(const APesagem: TPesagem);
    procedure AplicarMortalidade(const AMortalidade: TMortalidade);

    property Id: Integer read FId;
    property Descricao: string read FDescricao;
    property DataEntrada: TDateTime read FDataEntrada;
    property QuantidadeInicial: Integer read FQuantidadeInicial;
    property PesoMedioGeral: Double read FPesoMedioGeral;
    property TotalMortalidade: Integer read FTotalMortalidade;
    property PercentualMortalidade: TPercentual read FPercentualMortalidade;
  end;

implementation

constructor TLote.Create(AId: Integer; const ADescricao: string; ADataEntrada: TDateTime; AQuantidadeInicial: Integer);
begin
  if AId <= 0 then
    raise EDomainException.Create('Id do lote inválido.');

  if AQuantidadeInicial <= 0 then
    raise EDomainException.Create('Quantidade inicial deve ser maior que zero.');

  FId := AId;
  FDescricao := ADescricao;
  FDataEntrada := ADataEntrada;
  FQuantidadeInicial := AQuantidadeInicial;
  FPercentualMortalidade := TPercentual.De(0);
end;

procedure TLote.AplicarPesagem(const APesagem: TPesagem);
begin
  if APesagem.LoteId <> FId then
    raise EDomainException.Create('Pesagem não pertence ao lote informado.');

  FPesoMedioGeral := APesagem.PesoMedio;
end;

procedure TLote.AplicarMortalidade(const AMortalidade: TMortalidade);
var
  LPercentual: Double;
begin
  if AMortalidade.LoteId <> FId then
    raise EDomainException.Create('Mortalidade não pertence ao lote informado.');

  FTotalMortalidade := FTotalMortalidade + AMortalidade.Quantidade;

  if FTotalMortalidade > FQuantidadeInicial then
    raise EDomainException.Create('Mortalidade acumulada não pode exceder a quantidade inicial.');

  LPercentual := (FTotalMortalidade / FQuantidadeInicial) * 100;
  FPercentualMortalidade := TPercentual.De(LPercentual);
end;

end.
