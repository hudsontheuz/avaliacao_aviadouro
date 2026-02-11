unit Presentation.Forms.uMortalidade;

interface

uses
  Application.UseCases.RegistrarMortalidadeUseCase,
  Application.DTO.RegistrarMortalidadeDTO;

type
  TMortalidadePresenter = class
  private
    FUseCase: TRegistrarMortalidadeUseCase;
  public
    constructor Create(AUseCase: TRegistrarMortalidadeUseCase);
    procedure Registrar(const ADTO: TRegistrarMortalidadeDTO);
  end;

implementation

constructor TMortalidadePresenter.Create(AUseCase: TRegistrarMortalidadeUseCase);
begin
  FUseCase := AUseCase;
end;

procedure TMortalidadePresenter.Registrar(const ADTO: TRegistrarMortalidadeDTO);
begin
  FUseCase.Executar(ADTO);
end;

end.
