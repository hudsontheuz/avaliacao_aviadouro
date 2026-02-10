unit ResumoLoteDTO;

interface

type
  TResumoLoteDTO = record
    IdLote: Integer;
    Descricao: string;
    QuantidadeInicial: Integer;
    PesoMedioAtual: Double;
    TotalMortes: Integer;
    PercentualMortalidade: Double;
    FaixaSaude: string;
  end;

implementation

end.
