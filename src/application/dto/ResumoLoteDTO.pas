unit Application.DTO.ResumoLoteDTO;

interface

type
  TResumoLoteDTO = record
    LoteId: Integer;
    Descricao: string;
    QuantidadeInicial: Integer;
    PesoMedioGeral: Double;
    TotalMortalidade: Integer;
    PercentualMortalidade: Double;
    IndicadorCor: string;
  end;

implementation

end.
