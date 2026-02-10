unit presentation.forms.uMortalidade;

interface

uses
  application.dto.RegistrarMortalidadeDTO,
  application.dto.ResumoLoteDTO,
  application.usecases.RegistrarMortalidadeUseCase;

type
  TMortalidadeController = class
  private
    FUseCase: TRegistrarMortalidadeUseCase;
  public
    constructor Create(AUseCase: TRegistrarMortalidadeUseCase);
    function Salvar(AIdLote: Integer; AQuantidadeMorta: Integer; const AObservacao: string): TResumoLoteDTO;
  end;

implementation

constructor TMortalidadeController.Create(AUseCase: TRegistrarMortalidadeUseCase);
begin
  FUseCase := AUseCase;
end;

function TMortalidadeController.Salvar(AIdLote, AQuantidadeMorta: Integer;
  const AObservacao: string): TResumoLoteDTO;
var
  DTO: TRegistrarMortalidadeDTO;
begin
  DTO.IdLote := AIdLote;
  DTO.QuantidadeMorta := AQuantidadeMorta;
  DTO.Observacao := AObservacao;

  Result := FUseCase.Executar(DTO);
end;

end.
