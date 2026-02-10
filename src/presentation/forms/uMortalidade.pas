unit uMortalidade;

interface

uses
  RegistrarMortalidadeDTO,
  RegistrarMortalidadeUseCase;

type
  TFrmMortalidade = class
  private
    FUseCase: TRegistrarMortalidadeUseCase;
  public
    constructor Create(AUseCase: TRegistrarMortalidadeUseCase);
    procedure SalvarMortalidade(const AInput: TRegistrarMortalidadeDTO);
  end;

implementation

constructor TFrmMortalidade.Create(AUseCase: TRegistrarMortalidadeUseCase);
begin
  FUseCase := AUseCase;
end;

procedure TFrmMortalidade.SalvarMortalidade(const AInput: TRegistrarMortalidadeDTO);
begin
  FUseCase.Executar(AInput);
end;

end.
