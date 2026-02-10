unit Presentation.Composition.Container;

interface

uses
  Application.UseCases.RegistrarPesagemUseCase,
  Application.UseCases.RegistrarMortalidadeUseCase,
  Application.UseCases.ObterResumoLoteUseCase,
  Infrastructure.Persistence.Repositories.LoteRepositoryFD,
  Infrastructure.Persistence.Repositories.PesagemRepositoryFD,
  Infrastructure.Persistence.Repositories.MortalidadeRepositoryFD,
  Application.Ports.ILoteRepository,
  Application.Ports.IPesagemRepository,
  Application.Ports.IMortalidadeRepository;

type
  TContainer = class
  private
    FLoteRepository: ILoteRepository;
    FPesagemRepository: IPesagemRepository;
    FMortalidadeRepository: IMortalidadeRepository;
  public
    constructor Create;
    function CriarRegistrarPesagemUseCase: TRegistrarPesagemUseCase;
    function CriarRegistrarMortalidadeUseCase: TRegistrarMortalidadeUseCase;
    function CriarObterResumoLoteUseCase: TObterResumoLoteUseCase;
  end;

implementation

constructor TContainer.Create;
begin
  FLoteRepository := TLoteRepositoryFD.Create;
  FPesagemRepository := TPesagemRepositoryFD.Create;
  FMortalidadeRepository := TMortalidadeRepositoryFD.Create;
end;

function TContainer.CriarRegistrarPesagemUseCase: TRegistrarPesagemUseCase;
begin
  Result := TRegistrarPesagemUseCase.Create(FLoteRepository, FPesagemRepository);
end;

function TContainer.CriarRegistrarMortalidadeUseCase: TRegistrarMortalidadeUseCase;
begin
  Result := TRegistrarMortalidadeUseCase.Create(FLoteRepository, FMortalidadeRepository);
end;

function TContainer.CriarObterResumoLoteUseCase: TObterResumoLoteUseCase;
begin
  Result := TObterResumoLoteUseCase.Create(FLoteRepository);
end;

end.
