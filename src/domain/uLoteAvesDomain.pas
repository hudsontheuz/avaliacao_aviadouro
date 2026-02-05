unit uLoteAvesDomain;

interface

type
  TLoteAves = class
  private
    FId: Integer;
    FDescricao: string;
    FQuantidadeInicial: Integer;
    FPesoMedioGeral: Double;
  public
    constructor Create(AId: Integer; ADescricao: string; AQtdInicial: Integer);

    function CalcularPercentualMortalidade(ATotalMortes: Integer): Double;

    property Id: Integer read FId;
    property Descricao: string read FDescricao;
    property QuantidadeInicial: Integer read FQuantidadeInicial;
    property PesoMedioGeral: Double read FPesoMedioGeral write FPesoMedioGeral;
  end;

implementation

constructor TLoteAves.Create(AId: Integer; ADescricao: string; AQtdInicial: Integer);
begin
  FId := AId;
  FDescricao := ADescricao;
  FQuantidadeInicial := AQtdInicial;
end;

function TLoteAves.CalcularPercentualMortalidade(ATotalMortes: Integer): Double;
begin
  if FQuantidadeInicial = 0 then
    Exit(0);

  Result := (ATotalMortes / FQuantidadeInicial) * 100.0;
end;

end.

