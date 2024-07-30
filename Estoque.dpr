program Estoque;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  UnitCadProd in 'UnitCadProd.pas' {FormCadProd},
  UnitCadMoviment in 'UnitCadMoviment.pas' {FormCadMoviment},
  UnitConsMoviment in 'UnitConsMoviment.pas' {FormConsMoviment},
  UnitDM in 'UnitDM.pas' {DM_Estoque: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormCadProd, FormCadProd);
  Application.CreateForm(TFormCadMoviment, FormCadMoviment);
  Application.CreateForm(TFormConsMoviment, FormConsMoviment);
  Application.CreateForm(TDM_Estoque, DM_Estoque);
  Application.Run;
end.
