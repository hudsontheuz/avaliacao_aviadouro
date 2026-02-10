unit presentation.forms.uPesagem;

interface

uses
  application.dto.RegistrarPesagemDTO,
  application.usecases.RegistrarPesagemUseCase;

type
  TPesagemController = class
  private
    FUseCase: TRegistrarPesagemUseCase;
  public
    constructor Create(AUseCase: TRegistrarPesagemUseCase);
    procedure Salvar(AIdLote: Integer; AQuantidadePesada: Integer; APesoMedio: Double);
  end;

implementation

constructor TPesagemController.Create(AUseCase: TRegistrarPesagemUseCase);
begin
  FUseCase := AUseCase;
end;

procedure TPesagemController.Salvar(AIdLote, AQuantidadePesada: Integer;
  APesoMedio: Double);
var
  DTO: TRegistrarPesagemDTO;
begin
  DTO.IdLote := AIdLote;
  DTO.QuantidadePesada := AQuantidadePesada;
  DTO.PesoMedio := APesoMedio;

  FUseCase.Executar(DTO);
end;

end.
