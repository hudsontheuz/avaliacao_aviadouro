object frmLoteAves: TfrmLoteAves
  Left = 0
  Top = 0
  Caption = 'frmLoteAves'
  ClientHeight = 587
  ClientWidth = 1084
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object dbgLoteAves: TDBGrid
    Left = 497
    Top = 98
    Width = 587
    Height = 489
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object pnlLoteAves: TPanel
    Left = 0
    Top = 0
    Width = 1084
    Height = 98
    Align = alTop
    Caption = 'Tela de Inscri'#231#227'o de Lote de Aves'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -37
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 930
  end
  object pnlCadastroLote: TPanel
    Left = 0
    Top = 98
    Width = 497
    Height = 489
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object lblDescricao: TLabel
      Left = 8
      Top = 147
      Width = 56
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object lblQuantidadeInicial: TLabel
      Left = 8
      Top = 299
      Width = 99
      Height = 15
      Caption = 'Quantidade Inicial'
    end
    object lblDataEntrada: TLabel
      Left = 8
      Top = 229
      Width = 89
      Height = 15
      Caption = 'Data de Entrada'
    end
    object lblID: TLabel
      Left = 8
      Top = 65
      Width = 12
      Height = 15
      Caption = 'ID'
    end
    object ED_DESCRICAO: TEdit
      Left = 8
      Top = 168
      Width = 459
      Height = 23
      TabOrder = 0
    end
    object btnSalvarLote: TButton
      Left = 320
      Top = 384
      Width = 113
      Height = 81
      Caption = 'Salvar Lote'
      TabOrder = 1
      OnClick = btnSalvarLoteClick
    end
    object btnNovoLote: TButton
      Left = 40
      Top = 384
      Width = 113
      Height = 81
      Caption = 'Novo Lote'
      TabOrder = 2
      OnClick = btnNovoLoteClick
    end
    object ED_ID: TEdit
      Left = 8
      Top = 86
      Width = 459
      Height = 23
      ReadOnly = True
      TabOrder = 3
    end
    object ED_QUANTIDADE_INICIAL: TEdit
      Left = 8
      Top = 320
      Width = 459
      Height = 23
      TabOrder = 4
      OnKeyPress = ED_QUANTIDADE_INICIALKeyPress
    end
    object ED_DATAENTRADA: TDateTimePicker
      Left = 8
      Top = 255
      Width = 459
      Height = 23
      Date = 46057.000000000000000000
      Time = 0.870751076392480200
      TabOrder = 5
    end
  end
end
