object frmMortalidade: TfrmMortalidade
  Left = 0
  Top = 0
  ClientHeight = 661
  ClientWidth = 1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object lblDataMortalidade: TLabel
    Left = 8
    Top = 195
    Width = 107
    Height = 15
    Caption = 'Data de Mortalidade'
  end
  object lblQuantidadeMorta: TLabel
    Left = 8
    Top = 315
    Width = 97
    Height = 15
    Caption = 'Quantidade Morta'
  end
  object lblObservacao: TLabel
    Left = 8
    Top = 467
    Width = 67
    Height = 15
    Caption = 'Observa'#231#245'es'
  end
  object pnlMortalidade: TPanel
    Left = 0
    Top = 0
    Width = 1082
    Height = 97
    Align = alTop
    Caption = 'Tela de Lan'#231'amentos de Mortalidade'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -37
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object dbgMortalidade: TDBGrid
    Left = 479
    Top = 97
    Width = 603
    Height = 499
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object ED_DATAMORTALIDADE: TDateTimePicker
    Left = 8
    Top = 216
    Width = 425
    Height = 23
    Date = 46058.000000000000000000
    Time = 0.479911574075231300
    TabOrder = 2
  end
  object ED_QUANTIDADEMORTA: TEdit
    Left = 8
    Top = 336
    Width = 425
    Height = 23
    TabOrder = 3
    OnKeyPress = ED_QUANTIDADEMORTAKeyPress
  end
  object ED_OBSERVACAO: TEdit
    Left = 8
    Top = 488
    Width = 425
    Height = 23
    TabOrder = 4
  end
  object btnSalvarMortalidade: TButton
    Left = 8
    Top = 525
    Width = 91
    Height = 65
    Caption = 'Salvar'
    TabOrder = 5
    OnClick = btnSalvarMortalidadeClick
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 596
    Width = 1082
    Height = 65
    Align = alBottom
    Caption = 'Indicador de Sa'#250'de'
    TabOrder = 6
    object Label1: TLabel
      Left = 183
      Top = 32
      Width = 77
      Height = 15
      Caption = 'Menor que 5%'
      Color = clDarkgreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 479
      Top = 32
      Width = 80
      Height = 15
      Caption = 'Entre 5% e 10%'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clOlive
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label3: TLabel
      Left = 741
      Top = 32
      Width = 75
      Height = 15
      Caption = 'Acima de 10%'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object pnlInidicador: TPanel
      Left = 24
      Top = 21
      Width = 65
      Height = 41
      TabOrder = 0
    end
    object pnlVerde: TPanel
      Left = 160
      Top = 29
      Width = 17
      Height = 20
      Color = clDarkgreen
      ParentBackground = False
      TabOrder = 1
    end
    object pnlAmarelo: TPanel
      Left = 456
      Top = 29
      Width = 17
      Height = 20
      Color = clYellow
      ParentBackground = False
      TabOrder = 2
    end
    object Panel4: TPanel
      Left = 718
      Top = 29
      Width = 17
      Height = 20
      Color = clRed
      ParentBackground = False
      TabOrder = 3
    end
  end
  object pnlIndicadorDeLote: TPanel
    Left = 0
    Top = 103
    Width = 473
    Height = 66
    TabOrder = 7
    object lblLote: TLabel
      Left = 8
      Top = 11
      Width = 23
      Height = 15
      Caption = 'Lote'
    end
    object lkpLote: TDBLookupComboBox
      Left = 8
      Top = 32
      Width = 433
      Height = 23
      TabOrder = 0
      OnClick = lkpLoteClick
    end
  end
end
