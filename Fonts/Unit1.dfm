object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Visualizador de Produto'
  ClientHeight = 438
  ClientWidth = 619
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    Left = 10
    Top = 45
    Width = 143
    Height = 19
    Caption = 'T'#237'tulo do Produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object imgProduct: TImage
    Left = 10
    Top = 80
    Width = 300
    Height = 300
    Center = True
    Proportional = True
    Stretch = True
  end
  object btnGetProduct: TButton
    Left = 10
    Top = 10
    Width = 150
    Height = 25
    Caption = 'Buscar Produto'
    TabOrder = 0
    OnClick = btnGetProductClick
  end
end
