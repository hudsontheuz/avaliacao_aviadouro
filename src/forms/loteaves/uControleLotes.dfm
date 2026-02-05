object frmControleLotes: TfrmControleLotes
  Left = 0
  Top = 0
  Caption = 'frmControleLotes'
  ClientHeight = 548
  ClientWidth = 1043
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object pnlControleLotes: TPanel
    Left = 0
    Top = 0
    Width = 1043
    Height = 89
    Align = alTop
    Caption = 'Tela de Controle de Lotes'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -37
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object gbControleLotes: TGroupBox
    Left = 0
    Top = 89
    Width = 185
    Height = 459
    Align = alLeft
    Caption = 'Escolha um id'
    TabOrder = 1
    object lblID: TLabel
      Left = 16
      Top = 59
      Width = 11
      Height = 15
      Caption = 'ID'
    end
    object lkpLote: TDBLookupComboBox
      Left = 16
      Top = 80
      Width = 145
      Height = 23
      TabOrder = 0
      OnClick = lkpLoteClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 185
    Top = 89
    Width = 858
    Height = 459
    Align = alClient
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
end
