unit uPesagem;

interface

uses
  RegistrarPesagemDTO,
  RegistrarPesagemUseCase;

type
  TFrmPesagem = class
  private
    FUseCase: TRegistrarPesagemUseCase;
  public
    constructor Create(AUseCase: TRegistrarPesagemUseCase);
    procedure SalvarPesagem(const AInput: TRegistrarPesagemDTO);
  end;

implementation

constructor TFrmPesagem.Create(AUseCase: TRegistrarPesagemUseCase);
begin
  FUseCase := AUseCase;
end;

procedure TFrmPesagem.SalvarPesagem(const AInput: TRegistrarPesagemDTO);
begin
  FUseCase.Executar(AInput);
end;

end.
