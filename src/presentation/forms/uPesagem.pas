unit Presentation.Forms.uPesagem;

interface

uses
  Application.UseCases.RegistrarPesagemUseCase,
  Application.DTO.RegistrarPesagemDTO;

type
  TPesagemPresenter = class
  private
    FUseCase: TRegistrarPesagemUseCase;
  public
    constructor Create(AUseCase: TRegistrarPesagemUseCase);
    procedure Registrar(const ADTO: TRegistrarPesagemDTO);
  end;

implementation

constructor TPesagemPresenter.Create(AUseCase: TRegistrarPesagemUseCase);
begin
  FUseCase := AUseCase;
end;

procedure TPesagemPresenter.Registrar(const ADTO: TRegistrarPesagemDTO);
begin
  FUseCase.Executar(ADTO);
end;

end.
