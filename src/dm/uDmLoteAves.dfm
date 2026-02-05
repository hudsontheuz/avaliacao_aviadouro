object dmLoteAves: TdmLoteAves
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object conFirebird: TFDConnection
    LoginPrompt = False
    Left = 72
    Top = 56
  end
  object qryLoteAves: TFDQuery
    Connection = conFirebird
    SQL.Strings = (
      'SELECT'
      '  ID_LOTE,'
      '  DESCRICAO,'
      '  DATA_ENTRADA,'
      '  QUANTIDADE_INICIAL,'
      '  PESO_MEDIO_GERAL'
      'FROM TAB_LOTE_AVES'
      'ORDER BY ID_LOTE'
      '')
    Left = 208
    Top = 56
  end
  object qryPesagem: TFDQuery
    Connection = conFirebird
    SQL.Strings = (
      'SELECT'
      '  ID_PESAGEM,'
      '  ID_LOTE_FK,'
      '  DATA_PESAGEM,'
      '  PESO_MEDIO,'
      '  QUANTIDADE_PESADA'
      'FROM TAB_PESAGEM'
      'WHERE ID_LOTE_FK = :ID_LOTE'
      'ORDER BY DATA_PESAGEM DESC'
      '')
    Left = 208
    Top = 136
    ParamData = <
      item
        Name = 'ID_LOTE'
        ParamType = ptInput
      end>
  end
  object qryMortalidade: TFDQuery
    Connection = conFirebird
    SQL.Strings = (
      'SELECT'
      '  ID_MORTALIDADE,'
      '  ID_LOTE_FK,'
      '  DATA_MORTALIDADE,'
      '  QUANTIDADE_MORTA,'
      '  OBSERVACAO'
      'FROM TAB_MORTALIDADE'
      'WHERE ID_LOTE_FK = :ID_LOTE'
      'ORDER BY DATA_MORTALIDADE DESC'
      '')
    Left = 208
    Top = 208
    ParamData = <
      item
        Name = 'ID_LOTE'
        ParamType = ptInput
      end>
  end
  object spInserirMortalidade: TFDStoredProc
    Connection = conFirebird
    StoredProcName = 'PRCD_INSERIR_MORTALIDADE'
    Left = 56
    Top = 304
  end
  object spInserirPesagem: TFDStoredProc
    Connection = conFirebird
    StoredProcName = 'PRCD_INSERIR_PESAGEM'
    Left = 56
    Top = 368
  end
  object dsLoteAves: TDataSource
    DataSet = qryLoteAves
    Left = 352
    Top = 48
  end
  object dsPesagem: TDataSource
    DataSet = qryPesagem
    Left = 344
    Top = 144
  end
  object dsMortalidade: TDataSource
    DataSet = qryMortalidade
    Left = 344
    Top = 216
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files\Firebird\Firebird_4_0\fbclient.dll'
    Left = 72
    Top = 160
  end
end
