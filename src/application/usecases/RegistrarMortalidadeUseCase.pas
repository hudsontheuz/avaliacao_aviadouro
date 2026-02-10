unit RegistrarMortalidadeUseCase;

interface

uses
  RegistrarMortalidadeDTO,
  IMortalidadeRepository,
  Mortalidade;

type
  TRegistrarMortalidadeUseCase = class
  private
    FMortalidadeRepository: IMortalidadeRepository;
  public
    constructor Create(const AMortalidadeRepository: IMortalidadeRepository);
    procedure Executar(const AInput: TRegistrarMortalidadeDTO);
  end;

implementation

constructor TRegistrarMortalidadeUseCase.Create(const AMortalidadeRepository: IMortalidadeRepository);
begin
  FMortalidadeRepository := AMortalidadeRepository;
end;

procedure TRegistrarMortalidadeUseCase.Executar(const AInput: TRegistrarMortalidadeDTO);
var
  LMortalidade: TMortalidade;
begin
  LMortalidade := TMortalidade.Create(AInput.IdLote, AInput.DataMortalidade, AInput.QuantidadeMorta);
  try
    FMortalidadeRepository.Inserir(LMortalidade);
  finally
    LMortalidade.Free;
  end;
end;

end.
