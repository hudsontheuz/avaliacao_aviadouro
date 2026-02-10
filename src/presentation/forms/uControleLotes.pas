unit presentation.forms.uControleLotes;

interface

uses
  application.dto.ResumoLoteDTO,
  application.usecases.ObterResumoLoteUseCase;

type
  TControleLotesController = class
  private
    FUseCase: TObterResumoLoteUseCase;
  public
    constructor Create(AUseCase: TObterResumoLoteUseCase);
    function ObterResumo(AIdLote: Integer): TResumoLoteDTO;
  end;

implementation

constructor TControleLotesController.Create(AUseCase: TObterResumoLoteUseCase);
begin
  FUseCase := AUseCase;
end;

function TControleLotesController.ObterResumo(AIdLote: Integer): TResumoLoteDTO;
begin
  Result := FUseCase.Executar(AIdLote);
end;

end.
