unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    mnuLoteAves: TMenuItem;
    mnuPesagem: TMenuItem;
    mnuMortalidade: TMenuItem;
    mnuLancamentoPesagem: TMenuItem;
    mnLnacamentoMortalidade: TMenuItem;
    pnlContainer: TPanel;
    imgLogo: TImage;
    mnuInscriçãoLoteAves: TMenuItem;
    mnuControleLoteAves: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mnuLancamentoPesagemClick(Sender: TObject);
    procedure mnLnacamentoMortalidadeClick(Sender: TObject);
    procedure mnuInscriçãoLoteAvesClick(Sender: TObject);
    procedure mnuControleLoteAvesClick(Sender: TObject);
  private
    FormAtual: TForm;
    procedure TrocarTela(NovaTela: TFormClass);
  public
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses
  uLoteAves, uPesagem, uMortalidade, uControleLotes;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  TrocarTela(TFrmPrincipal);
end;

procedure TFrmPrincipal.TrocarTela(NovaTela: TFormClass);
begin
  if Assigned(FormAtual) then
    FreeAndNil(FormAtual);

  FormAtual := NovaTela.Create(Self);
  FormAtual.BorderStyle := bsNone;
  FormAtual.Align := alClient;
  FormAtual.Parent := pnlContainer;
  FormAtual.Visible := True;
end;

procedure TFrmPrincipal.mnuControleLoteAvesClick(Sender: TObject);
begin
  TrocarTela(TfrmControleLotes);
end;

procedure TFrmPrincipal.mnuInscriçãoLoteAvesClick(Sender: TObject);
begin
  TrocarTela(TfrmLoteAves);
end;

procedure TFrmPrincipal.mnuLancamentoPesagemClick(Sender: TObject);
begin
  TrocarTela(TfrmPesagem);
end;

procedure TFrmPrincipal.mnLnacamentoMortalidadeClick(Sender: TObject);
begin
  TrocarTela(TfrmMortalidade);
end;

end.

