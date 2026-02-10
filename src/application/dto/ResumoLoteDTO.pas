unit application.dto.ResumoLoteDTO;

interface

type
  TResumoLoteDTO = record
    IdLote: Integer;
    QuantidadeInicial: Integer;
    TotalPesado: Integer;
    TotalMortes: Integer;
    PercentualMortalidade: Double;
    IndicadorSaude: string;
  end;

implementation

end.
