object frmRelVendas: TfrmRelVendas
  Left = 0
  Top = 0
  Caption = 'frmRelVendas'
  ClientHeight = 602
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 32
    Top = 8
    Width = 794
    Height = 1123
    DataSource = dsRel
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 91
      BandType = btHeader
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 91
        Align = faClient
      end
      object RLLabel1: TRLLabel
        Left = 176
        Top = 30
        Width = 365
        Height = 30
        Align = faCenter
        Caption = 'RELAT'#211'RIO DE VENDAS POR CLIENTE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object RLGroup1: TRLGroup
      Left = 38
      Top = 129
      Width = 718
      Height = 192
      DataFields = 'CodigoVenda'
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 40
        BandType = btColumnHeader
        object RLDraw1: TRLDraw
          Left = 0
          Top = -1
          Width = 718
          Height = 21
        end
        object RLLabel2: TRLLabel
          Left = 12
          Top = 1
          Width = 67
          Height = 17
          Caption = 'N'#186' Venda:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText1: TRLDBText
          Left = 82
          Top = 1
          Width = 84
          Height = 17
          DataField = 'CodigoVenda'
          DataSource = dsRel
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 0
          Top = 19
          Width = 718
          Height = 21
        end
        object RLLabel3: TRLLabel
          Left = 12
          Top = 21
          Width = 48
          Height = 17
          Caption = 'C'#243'digo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel4: TRLLabel
          Left = 71
          Top = 21
          Width = 63
          Height = 17
          Caption = 'Descri'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel5: TRLLabel
          Left = 451
          Top = 21
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Unit'#225'rio'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel6: TRLLabel
          Left = 539
          Top = 21
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Quantidade'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel7: TRLLabel
          Left = 628
          Top = 21
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 40
        Width = 718
        Height = 20
        object RLDraw4: TRLDraw
          Left = 0
          Top = -1
          Width = 718
          Height = 21
        end
        object RLDBText2: TRLDBText
          Left = 12
          Top = 1
          Width = 57
          Height = 17
          AutoSize = False
          DataField = 'ProdutoId'
          DataSource = dsRel
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 71
          Top = 2
          Width = 374
          Height = 17
          AutoSize = False
          DataField = 'Descricao'
          DataSource = dsRel
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 451
          Top = 1
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'Unitario'
          DataSource = dsRel
          Text = ''
        end
        object RLDBText5: TRLDBText
          Left = 539
          Top = 1
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'Quantidade'
          DataSource = dsRel
          Text = ''
        end
        object RLDBText6: TRLDBText
          Left = 628
          Top = 1
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'Total'
          DataSource = dsRel
          Text = ''
        end
      end
    end
  end
  object cdsRel: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 368
    object cdsRelCodigoVenda: TIntegerField
      FieldName = 'CodigoVenda'
    end
    object cdsRelData: TDateField
      FieldName = 'Data'
    end
    object cdsRelProdutoId: TIntegerField
      FieldName = 'ProdutoId'
    end
    object cdsRelDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object cdsRelUnitario: TFloatField
      FieldName = 'Unitario'
      DisplayFormat = ',#0.00'
      EditFormat = '0.00'
    end
    object cdsRelQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = ',#0.00'
      EditFormat = '0.00'
    end
    object cdsRelTotal: TFloatField
      FieldName = 'Total'
      DisplayFormat = ',#0.00'
      EditFormat = '0.00'
    end
  end
  object dsRel: TDataSource
    DataSet = cdsRel
    Left = 406
    Top = 369
  end
end
