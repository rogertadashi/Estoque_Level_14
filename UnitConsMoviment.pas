unit UnitConsMoviment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TFormConsMoviment = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    txtDataInicial: TMaskEdit;
    txtDataFinal: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    btConsultar: TButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Label4: TLabel;
    lblTotal: TLabel;
    procedure btConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConsMoviment: TFormConsMoviment;

implementation

{$R *.dfm}

uses UnitDM;

procedure TFormConsMoviment.btConsultarClick(Sender: TObject);
begin
  DM_Estoque.SQL_Movimentacoes.Close;
  DM_Estoque.SQL_Movimentacoes.SQL.Clear;
  DM_Estoque.SQL_Movimentacoes.SQL.Text :='SELECT * FROM movimentacoes WHERE Date (data_e_hora) BETWEEN :pDataInicial AND :pDataFinal';
  DM_Estoque.SQL_Movimentacoes.ParamByName('pDataInicial').Value := FormatDateTime('yyy-mm-dd',StrToDate(txtDataInicial.Text));
  DM_Estoque.SQL_Movimentacoes.ParamByName('pDataFinal').Value := FormatDateTime('yyy-mm-dd',StrToDate(txtDataFinal.Text));
  DM_Estoque.SQL_Movimentacoes.Open;

  lblTotal.Caption := IntToStr(DM_Estoque.SQL_Movimentacoes.RecordCount);

end;

procedure TFormConsMoviment.FormShow(Sender: TObject);
begin
  DM_Estoque.SQL_Movimentacoes.Refresh;
  DM_Estoque.SQL_Moviment_Prod.Refresh;
  lblTotal.Caption := IntToStr(DM_Estoque.SQL_Movimentacoes.RecordCount);
end;
end.






