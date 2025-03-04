unit UnitCadMoviment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFormCadMoviment = class(TForm)
    Label1: TLabel;
    txtResponsavel: TDBEdit;
    Label2: TLabel;
    DBComboBox1: TDBComboBox;
    Label3: TLabel;
    txtDataEHora: TDBEdit;
    DBMemo1: TDBMemo;
    Label4: TLabel;
    Observações: TLabel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Label6: TLabel;
    DBNavigator2: TDBNavigator;
    DBLookupComboBox1: TDBLookupComboBox;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    Label7: TLabel;
    DBGrid2: TDBGrid;
    Label8: TLabel;
    Label9: TLabel;
    txtTotalProdutos: TLabel;
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadMoviment: TFormCadMoviment;

implementation

{$R *.dfm}

uses UnitDM;

procedure TFormCadMoviment.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button = nbInsert then
  begin
    DM_Estoque.tb_Movimentos.FieldByName('data_e_hora').Value := Now
  end;

end;

procedure TFormCadMoviment.FormShow(Sender: TObject);
begin
  DM_estoque.calcularTotais;
end;

end.
