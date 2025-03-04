unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client , Vcl.Dialogs;

type
  TDM_Estoque = class(TDataModule)
    Conexao: TFDConnection;
    Tb_Produtos: TFDTable;
    TB_Movimentos: TFDTable;
    TB_Moviment_Prod: TFDTable;
    DS_Produtos: TDataSource;
    DS_Movimentos: TDataSource;
    DS_Moviment_Prod: TDataSource;
    SQL_Aumenta_Estoque: TFDCommand;
    SQL_Diminui_Estoque: TFDCommand;
    SQL_Movimentacoes: TFDQuery;
    DS_SQL_Movimentacoes: TDataSource;
    Tb_Produtosid: TFDAutoIncField;
    Tb_Produtosnome: TStringField;
    Tb_Produtosfabricante: TStringField;
    Tb_Produtosvalidade: TDateField;
    Tb_ProdutosestoqueAtual: TIntegerField;
    TB_Moviment_Prodid: TFDAutoIncField;
    TB_Moviment_Prodid_Movimentacao: TIntegerField;
    TB_Moviment_Prodid_Produto: TIntegerField;
    TB_Moviment_Prodquant: TIntegerField;
    TB_Moviment_ProdNome_Produto: TStringField;
    SQL_Moviment_Prod: TFDQuery;
    DS_SQL_Moviment_Prod: TDataSource;
    SQL_Moviment_Prodid: TFDAutoIncField;
    SQL_Moviment_Prodid_Movimentacao: TIntegerField;
    SQL_Moviment_Prodid_Produto: TIntegerField;
    SQL_Moviment_Prodquant: TIntegerField;
    SQL_Moviment_Prodnome_produto: TStringField;
    procedure TB_Moviment_ProdAfterPost(DataSet: TDataSet);
    procedure TB_Moviment_ProdAfterDelete(DataSet: TDataSet);
    procedure calcularTotais;
    procedure TB_MovimentosAfterScroll(DataSet: TDataSet);
    procedure TB_Moviment_ProdBeforeDelete(DataSet: TDataSet);
    procedure TB_MovimentosBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_Estoque: TDM_Estoque;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UnitConsMoviment, UnitCadMoviment;

{$R *.dfm}

procedure TDM_Estoque.calcularTotais;
var
  totais : Integer;
begin
  if TB_Moviment_Prod.State in [dsBrowse] then
          begin
            TB_Moviment_Prod.First;

                while not TB_Moviment_Prod.Eof do
                  begin
                  totais := totais + TB_Moviment_Prod.FieldByName('quant').Value;

                  TB_Moviment_Prod.Next;
                  end;

            FormCadMoviment.txtTotalProdutos.Caption := IntToStr(totais);
          end;
end;

procedure TDM_Estoque.TB_MovimentosAfterScroll(DataSet: TDataSet);
begin
  calcularTotais;
end;

procedure TDM_Estoque.TB_MovimentosBeforeDelete(DataSet: TDataSet);
begin
  if (TB_Moviment_Prod.RecordCount > 0) then
    begin
      ShowMessage('Existem produtos cadastrados nessa movimenta��o . Exclua-os primeiro.');
      abort;
    end;
end;

procedure TDM_Estoque.TB_Moviment_ProdAfterDelete(DataSet: TDataSet);
begin
  calcularTotais;
end;

procedure TDM_Estoque.TB_Moviment_ProdAfterPost(DataSet: TDataSet);
begin
  calcularTotais;

   if (TB_Movimentos.FieldByName('tipo').Value = 'Entrada no Estoque') then
    begin
        SQL_Aumenta_Estoque.ParamByName('pID').Value := TB_Moviment_Prod.FieldByName('id_Produto').Value;
        SQL_Aumenta_Estoque.ParamByName('pQtd').Value := TB_Moviment_Prod.FieldByName('quant').Value;
        SQL_Aumenta_Estoque.Execute;
    end;

     if (TB_Movimentos.FieldByName('tipo').Value = 'Sa�da do Estoque') then
    begin
        SQL_Diminui_Estoque.ParamByName('pID').Value := TB_Moviment_Prod.FieldByName('id_Produto').Value;
        SQL_Diminui_Estoque.ParamByName('pQtd').Value :=TB_Moviment_Prod.FieldByName('quant').Value;
        SQL_Diminui_Estoque.Execute;
    end;


end;


procedure TDM_Estoque.TB_Moviment_ProdBeforeDelete(DataSet: TDataSet);
begin

     if (TB_Movimentos.FieldByName('tipo').Value = 'Entrada no Estoque') then
    begin
        SQL_Diminui_Estoque.ParamByName('pID').Value := TB_Moviment_Prod.FieldByName('id_Produto').Value;
        SQL_Diminui_Estoque.ParamByName('pQtd').Value := TB_Moviment_Prod.FieldByName('quant').Value;
        SQL_Diminui_Estoque.Execute;
    end;

     if (TB_Movimentos.FieldByName('tipo').Value = 'Sa�da do Estoque') then
    begin
        SQL_Aumenta_Estoque.ParamByName('pID').Value := TB_Moviment_Prod.FieldByName('id_Produto').Value;
        SQL_Aumenta_Estoque.ParamByName('pQtd').Value :=TB_Moviment_Prod.FieldByName('quant').Value;
        SQL_Aumenta_Estoque.Execute;
    end;
end;

end.
