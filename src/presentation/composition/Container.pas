unit Container;

interface

uses
  FireDAC.Comp.Client,
  FirebirdConnectionFactory,
  ILoteRepository,
  IPesagemRepository,
  IMortalidadeRepository,
  LoteRepositoryFD,
  PesagemRepositoryFD,
  MortalidadeRepositoryFD,
  RegistrarPesagemUseCase,
  RegistrarMortalidadeUseCase,
  ObterResumoLoteUseCase;

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

    function RegistrarPesagemUseCase: TRegistrarPesagemUseCase;
    function RegistrarMortalidadeUseCase: TRegistrarMortalidadeUseCase;
    function ObterResumoLoteUseCase: TObterResumoLoteUseCase;
  end;

implementation

constructor TContainer.Create;
begin
  FConnection := TFirebirdConnectionFactory.Criar;
  FLoteRepository := TLoteRepositoryFD.Create(FConnection);
  FPesagemRepository := TPesagemRepositoryFD.Create(FConnection);
  FMortalidadeRepository := TMortalidadeRepositoryFD.Create(FConnection);
end;

destructor TContainer.Destroy;
begin
  FConnection.Free;
  inherited;
end;

function TContainer.RegistrarPesagemUseCase: TRegistrarPesagemUseCase;
begin
  Result := TRegistrarPesagemUseCase.Create(FLoteRepository, FPesagemRepository);
end;

function TContainer.RegistrarMortalidadeUseCase: TRegistrarMortalidadeUseCase;
begin
  Result := TRegistrarMortalidadeUseCase.Create(FMortalidadeRepository);
end;

function TContainer.ObterResumoLoteUseCase: TObterResumoLoteUseCase;
begin
  Result := TObterResumoLoteUseCase.Create(FLoteRepository, FMortalidadeRepository);
end;

end.
