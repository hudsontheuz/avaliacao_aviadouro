object frmPesagem: TfrmPesagem
  Left = 0
  Top = 0
  Caption = 'frmPesagem'
  ClientHeight = 765
  ClientWidth = 981
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 981
    Height = 98
    Align = alTop
    Caption = 'Tela de Lan'#231'amentos de Pesagens'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -37
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object dbgPesagem: TDBGrid
    Left = 465
    Top = 98
    Width = 516
    Height = 667
    Align = alClient
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object pnlPesagem: TPanel
    Left = 0
    Top = 98
    Width = 465
    Height = 667
    Align = alLeft
    TabOrder = 2
    object lblDataPesagem: TLabel
      Left = 24
      Top = 131
      Width = 91
      Height = 15
      Caption = 'Data de Pesagem'
    end
    object lblQuantidadePesada: TLabel
      Left = 24
      Top = 302
      Width = 102
      Height = 15
      Caption = 'Quantidade Pesada'
    end
    object lblPesoMedio: TLabel
      Left = 24
      Top = 438
      Width = 62
      Height = 15
      Caption = 'Peso M'#233'dio'
    end
    object EB_DATAPESAGEM: TDateTimePicker
      Left = 24
      Top = 152
      Width = 425
      Height = 23
      Date = 46057.000000000000000000
      Time = 0.880204317130846900
      TabOrder = 0
    end
    object ED_PESOMEDIO: TEdit
      Left = 24
      Top = 459
      Width = 425
      Height = 23
      TabOrder = 1
      OnKeyPress = ED_PESOMEDIOKeyPress
    end
    object ED_QUANTIDADEPESADA: TEdit
      Left = 24
      Top = 323
      Width = 425
      Height = 23
      TabOrder = 2
      OnKeyPress = ED_QUANTIDADEPESADAKeyPress
    end
    object btnSalvarPesagem: TButton
      Left = 40
      Top = 528
      Width = 97
      Height = 81
      Caption = 'Salvar Pesagem'
      TabOrder = 3
      OnClick = btnSalvarPesagemClick
    end
    object pnlLote: TPanel
      Left = 0
      Top = 0
      Width = 459
      Height = 125
      TabOrder = 4
      object lblLote: TLabel
        Left = 24
        Top = 51
        Width = 23
        Height = 15
        Caption = 'Lote'
      end
      object lkpLote: TDBLookupComboBox
        Left = 24
        Top = 72
        Width = 425
        Height = 23
        ListSource = dmLoteAves.dsLoteAves
        TabOrder = 0
        OnClick = lkpLoteClick
      end
    end
  end
end
