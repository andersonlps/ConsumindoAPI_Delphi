object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'e'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 112
    Top = 40
    Width = 393
    Height = 329
    Caption = 'GroupBox1'
    Color = clWhite
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object lblNomeOficial: TLabel
      Left = 136
      Top = 112
      Width = 3
      Height = 15
      Color = clMenu
      ParentColor = False
    end
    object lblCapital: TLabel
      Left = 136
      Top = 144
      Width = 3
      Height = 15
    end
    object lblRegiao: TLabel
      Left = 136
      Top = 176
      Width = 3
      Height = 15
    end
    object lblPopulacao: TLabel
      Left = 136
      Top = 208
      Width = 3
      Height = 15
    end
    object lblMoeda: TLabel
      Left = 136
      Top = 240
      Width = 3
      Height = 15
    end
    object lblPais: TLabel
      Left = 136
      Top = 19
      Width = 119
      Height = 15
      Caption = 'Digite o nome do pais:'
    end
    object edtPais: TEdit
      Left = 120
      Top = 40
      Width = 153
      Height = 23
      TabOrder = 0
    end
    object btnConsultar: TButton
      Left = 160
      Top = 69
      Width = 75
      Height = 25
      Caption = 'Consultar'
      TabOrder = 1
      OnClick = btnConsultarClick
    end
  end
end
