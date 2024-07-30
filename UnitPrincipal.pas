unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFormPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Sistema1: TMenuItem;
    Sair1: TMenuItem;
    Sair2: TMenuItem;
    CadastrodeProdutos1: TMenuItem;
    Movimentaes1: TMenuItem;
    GerenciarMovimentaes1: TMenuItem;
    ConsultarMovimentaes1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure CadastrodeProdutos1Click(Sender: TObject);
    procedure GerenciarMovimentaes1Click(Sender: TObject);
    procedure ConsultarMovimentaes1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses UnitCadMoviment, UnitCadProd, UnitConsMoviment, UnitDM;

procedure TFormPrincipal.CadastrodeProdutos1Click(Sender: TObject);
begin
  formCadProd.ShowModal;
end;

procedure TFormPrincipal.ConsultarMovimentaes1Click(Sender: TObject);
begin
  formConsMoviment.ShowModal;
end;

procedure TFormPrincipal.GerenciarMovimentaes1Click(Sender: TObject);
begin
  formCadMoviment.ShowModal;
end;

procedure TFormPrincipal.Sair1Click(Sender: TObject);
begin
 Application.Terminate;
end;

end.
