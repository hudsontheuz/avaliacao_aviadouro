program AvaliacaoAviario;

uses
  Vcl.Forms,
  uDmLoteAves in 'src\dm\uDmLoteAves.pas' {dmLoteAves: TDataModule},
  uLoteAves in 'src\forms\loteaves\uLoteAves.pas' {Form1},
  uPrincipal in 'src\forms\principal\uPrincipal.pas' {FrmPrincipal},
  uPesagem in 'src\forms\pesagem\uPesagem.pas' {frmPesagem},
  uMortalidade in 'src\forms\mortalidade\uMortalidade.pas' {frmMortalidade},
  uLoteAvesDomain in 'src\domain\uLoteAvesDomain.pas',
  uPesagemDomain in 'src\domain\uPesagemDomain.pas',
  uMortalidadeDomain in 'src\domain\uMortalidadeDomain.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmLoteAves, dmLoteAves);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TfrmPesagem, frmPesagem);
  Application.CreateForm(TfrmLoteAves, frmLoteAves);
  Application.CreateForm(TfrmMortalidade, frmMortalidade);
  Application.Run;
end.
