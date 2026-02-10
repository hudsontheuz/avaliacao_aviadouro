unit uControleLotes;

interface

uses
  ResumoLoteDTO,
  ObterResumoLoteUseCase;

type
  TFrmControleLotes = class
  private
    FUseCase: TObterResumoLoteUseCase;
  public
    constructor Create(AUseCase: TObterResumoLoteUseCase);
    function CarregarResumo(AIdLote: Integer): TResumoLoteDTO;
  end;

implementation

constructor TFrmControleLotes.Create(AUseCase: TObterResumoLoteUseCase);
begin
  FUseCase := AUseCase;
end;

function TFrmControleLotes.CarregarResumo(AIdLote: Integer): TResumoLoteDTO;
begin
  Result := FUseCase.Executar(AIdLote);
end;

end.
