unit Presentation.Forms.uControleLotes;

interface

uses
  Application.UseCases.ObterResumoLoteUseCase,
  Application.DTO.ResumoLoteDTO;

type
  TControleLotesPresenter = class
  private
    FUseCase: TObterResumoLoteUseCase;
  public
    constructor Create(AUseCase: TObterResumoLoteUseCase);
    function CarregarResumo(ALoteId: Integer): TResumoLoteDTO;
  end;

implementation

constructor TControleLotesPresenter.Create(AUseCase: TObterResumoLoteUseCase);
begin
  FUseCase := AUseCase;
end;

function TControleLotesPresenter.CarregarResumo(ALoteId: Integer): TResumoLoteDTO;
begin
  Result := FUseCase.Executar(ALoteId);
end;

end.
