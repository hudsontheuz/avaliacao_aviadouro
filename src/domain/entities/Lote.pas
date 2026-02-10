unit domain.entities.Lote;

interface

uses
  domain.valueobjects.Percentual;

type
  TLote = class
  private
    FId: Integer;
    FDescricao: string;
    FQuantidadeInicial: Integer;
  public
    constructor Create(AId: Integer; const ADescricao: string; AQuantidadeInicial: Integer);
    function CalcularPercentualMortalidade(ATotalMortes: Integer): TPercentual;

    property Id: Integer read FId;
    property Descricao: string read FDescricao;
    property QuantidadeInicial: Integer read FQuantidadeInicial;
  end;

implementation

uses
  domain.exceptions.DomainException;

constructor TLote.Create(AId: Integer; const ADescricao: string;
  AQuantidadeInicial: Integer);
begin
  if AId <= 0 then
    raise EDomainException.Create('Id do lote inválido.');

  if AQuantidadeInicial <= 0 then
    raise EDomainException.Create('Quantidade inicial deve ser maior que zero.');

  FId := AId;
  FDescricao := ADescricao;
  FQuantidadeInicial := AQuantidadeInicial;
end;

function TLote.CalcularPercentualMortalidade(ATotalMortes: Integer): TPercentual;
var
  Valor: Double;
begin
  Valor := (ATotalMortes / FQuantidadeInicial) * 100;
  Result := TPercentual.Criar(Valor);
end;

end.
