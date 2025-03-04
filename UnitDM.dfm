object DM_Estoque: TDM_Estoque
  Height = 583
  Width = 795
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=estoque'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 128
    Top = 128
  end
  object Tb_Produtos: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = Conexao
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'estoque.produtos'
    Left = 264
    Top = 128
    object Tb_Produtosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object Tb_Produtosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 50
    end
    object Tb_Produtosfabricante: TStringField
      FieldName = 'fabricante'
      Origin = 'fabricante'
      Required = True
      Size = 40
    end
    object Tb_Produtosvalidade: TDateField
      FieldName = 'validade'
      Origin = 'validade'
      Required = True
      EditMask = '##/##/####;1;_'
    end
    object Tb_ProdutosestoqueAtual: TIntegerField
      FieldName = 'estoqueAtual'
      Origin = 'estoqueAtual'
    end
  end
  object TB_Movimentos: TFDTable
    Active = True
    BeforeDelete = TB_MovimentosBeforeDelete
    AfterScroll = TB_MovimentosAfterScroll
    IndexFieldNames = 'id'
    Connection = Conexao
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'estoque.movimentacoes'
    Left = 360
    Top = 128
  end
  object TB_Moviment_Prod: TFDTable
    Active = True
    AfterPost = TB_Moviment_ProdAfterPost
    BeforeDelete = TB_Moviment_ProdBeforeDelete
    AfterDelete = TB_Moviment_ProdAfterDelete
    IndexName = 'id_Movimentacao'
    MasterSource = DS_Movimentos
    MasterFields = 'id'
    Connection = Conexao
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'estoque.movimentacoes_produto'
    Left = 472
    Top = 128
    object TB_Moviment_Prodid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object TB_Moviment_Prodid_Movimentacao: TIntegerField
      FieldName = 'id_Movimentacao'
      Origin = 'id_Movimentacao'
      Required = True
    end
    object TB_Moviment_Prodid_Produto: TIntegerField
      FieldName = 'id_Produto'
      Origin = 'id_Produto'
      Required = True
    end
    object TB_Moviment_Prodquant: TIntegerField
      FieldName = 'quant'
      Origin = 'quant'
      Required = True
    end
    object TB_Moviment_ProdNome_Produto: TStringField
      FieldKind = fkLookup
      FieldName = 'Nome_Produto'
      LookupDataSet = Tb_Produtos
      LookupKeyFields = 'id'
      LookupResultField = 'nome'
      KeyFields = 'id_Produto'
      Size = 50
      Lookup = True
    end
  end
  object DS_Produtos: TDataSource
    DataSet = Tb_Produtos
    Left = 264
    Top = 224
  end
  object DS_Movimentos: TDataSource
    DataSet = TB_Movimentos
    Left = 360
    Top = 224
  end
  object DS_Moviment_Prod: TDataSource
    DataSet = TB_Moviment_Prod
    Left = 480
    Top = 224
  end
  object SQL_Aumenta_Estoque: TFDCommand
    Connection = Conexao
    CommandText.Strings = (
      
        'UPDATE produtos SET estoqueAtual = estoqueAtual + :pQtd WHERE id' +
        ' = :pID')
    ParamData = <
      item
        Name = 'pQtd'
        ParamType = ptInput
      end
      item
        Name = 'pID'
        ParamType = ptInput
      end>
    Left = 96
    Top = 352
  end
  object SQL_Diminui_Estoque: TFDCommand
    Connection = Conexao
    CommandText.Strings = (
      
        'UPDATE produtos SET estoqueAtual = estoqueAtual - :pQtd WHERE id' +
        ' = :pID')
    ParamData = <
      item
        Name = 'pQtd'
        ParamType = ptInput
      end
      item
        Name = 'pID'
        ParamType = ptInput
      end>
    Left = 96
    Top = 424
  end
  object SQL_Movimentacoes: TFDQuery
    Active = True
    Connection = Conexao
    SQL.Strings = (
      'SELECT * FROM movimentacoes')
    Left = 656
    Top = 360
  end
  object DS_SQL_Movimentacoes: TDataSource
    DataSet = SQL_Movimentacoes
    Left = 656
    Top = 432
  end
  object SQL_Moviment_Prod: TFDQuery
    Active = True
    IndexFieldNames = 'id_Movimentacao'
    MasterSource = DS_SQL_Movimentacoes
    MasterFields = 'id'
    Connection = Conexao
    SQL.Strings = (
      'SELECT * FROM movimentacoes_produto')
    Left = 376
    Top = 368
    object SQL_Moviment_Prodid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object SQL_Moviment_Prodid_Movimentacao: TIntegerField
      FieldName = 'id_Movimentacao'
      Origin = 'id_Movimentacao'
      Required = True
    end
    object SQL_Moviment_Prodid_Produto: TIntegerField
      FieldName = 'id_Produto'
      Origin = 'id_Produto'
      Required = True
    end
    object SQL_Moviment_Prodquant: TIntegerField
      FieldName = 'quant'
      Origin = 'quant'
      Required = True
    end
    object SQL_Moviment_Prodnome_produto: TStringField
      FieldKind = fkLookup
      FieldName = 'nome_produto'
      LookupDataSet = Tb_Produtos
      LookupKeyFields = 'id'
      LookupResultField = 'nome'
      KeyFields = 'id_Produto'
      Size = 50
      Lookup = True
    end
  end
  object DS_SQL_Moviment_Prod: TDataSource
    DataSet = SQL_Moviment_Prod
    Left = 376
    Top = 440
  end
end
