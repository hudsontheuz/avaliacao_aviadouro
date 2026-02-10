unit presentation.composition.Container;

interface

uses
  FireDAC.Comp.Client,
  application.usecases.RegistrarPesagemUseCase,
  application.usecases.RegistrarMortalidadeUseCase,
  application.usecases.ObterResumoLoteUseCase,
  application.ports.ILoteRepository,
  application.ports.IPesagemRepository,
  application.ports.IMortalidadeRepository;

type
  TContainer = class
  private
    FConnection: TFDConnection;
    FLoteRepository: ILoteRepository;
    FPesagemRepository: IPesagemRepository;
    FMortalidadeRepository: IMortalidadeRepository;
  public
    constructor Create;
    destructor Destroy; override;

    function CriarRegistrarPesagemUseCase: TRegistrarPesagemUseCase;
    function CriarRegistrarMortalidadeUseCase: TRegistrarMortalidadeUseCase;
    function CriarObterResumoLoteUseCase: TObterResumoLoteUseCase;
  end;

implementation

uses
  infrastructure.persistence.FirebirdConnectionFactory,
  infrastructure.persistence.Repositories.LoteRepositoryFD,
  infrastructure.persistence.Repositories.PesagemRepositoryFD,
  infrastructure.persistence.Repositories.MortalidadeRepositoryFD;

constructor TContainer.Create;
begin
  FConnection := TFirebirdConnectionFactory.CriarConexao;
  FConnection.Connected := True;

  FLoteRepository := TLoteRepositoryFD.Create(FConnection);
  FPesagemRepository := TPesagemRepositoryFD.Create(FConnection);
  FMortalidadeRepository := TMortalidadeRepositoryFD.Create(FConnection);
end;

destructor TContainer.Destroy;
begin
  FConnection.Free;
  inherited;
end;

function TContainer.CriarObterResumoLoteUseCase: TObterResumoLoteUseCase;
begin
  Result := TObterResumoLoteUseCase.Create(
    FLoteRepository,
    FPesagemRepository,
    FMortalidadeRepository
  );
end;

function TContainer.CriarRegistrarMortalidadeUseCase: TRegistrarMortalidadeUseCase;
begin
  Result := TRegistrarMortalidadeUseCase.Create(
    FLoteRepository,
    FMortalidadeRepository
  );
end;

function TContainer.CriarRegistrarPesagemUseCase: TRegistrarPesagemUseCase;
begin
  Result := TRegistrarPesagemUseCase.Create(
    FLoteRepository,
    FPesagemRepository
  );
end;

end.
