unit application.usecases.RegistrarPesagemUseCase;

interface

uses
  SysUtils,
  application.dto.RegistrarPesagemDTO,
  application.ports.ILoteRepository,
  application.ports.IPesagemRepository,
  domain.entities.Pesagem,
  domain.exceptions.DomainException;

type
  TRegistrarPesagemUseCase = class
  private
    FLoteRepository: ILoteRepository;
    FPesagemRepository: IPesagemRepository;
  public
    constructor Create(ALoteRepository: ILoteRepository; APesagemRepository: IPesagemRepository);
    procedure Executar(const AInput: TRegistrarPesagemDTO);
  end;

implementation

constructor TRegistrarPesagemUseCase.Create(ALoteRepository: ILoteRepository;
  APesagemRepository: IPesagemRepository);
begin
  FLoteRepository := ALoteRepository;
  FPesagemRepository := APesagemRepository;
end;

procedure TRegistrarPesagemUseCase.Executar(const AInput: TRegistrarPesagemDTO);
var
  Pesagem: TPesagem;
begin
  if not FLoteRepository.Existe(AInput.IdLote) then
    raise EDomainException.Create('Lote não encontrado.');

  Pesagem := TPesagem.Create(AInput.IdLote, Date, AInput.QuantidadePesada, AInput.PesoMedio);
  try
    FPesagemRepository.RegistrarPesagem(
      Pesagem.IdLote,
      Pesagem.QuantidadePesada,
      Pesagem.PesoMedio
    );
  finally
    Pesagem.Free;
  end;
end;

end.
