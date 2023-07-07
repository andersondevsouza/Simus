object frmRelCliente: TfrmRelCliente
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Clientes'
  ClientHeight = 555
  ClientWidth = 860
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
    Top = 0
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
        Left = 237
        Top = 30
        Width = 243
        Height = 30
        Align = faCenter
        Caption = 'RELAT'#211'RIO DE CLIENTES'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 129
      Width = 718
      Height = 20
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
      object RLLabel3: TRLLabel
        Left = 90
        Top = 1
        Width = 41
        Height = 17
        Caption = 'Nome'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel4: TRLLabel
        Left = 586
        Top = 1
        Width = 42
        Height = 17
        Caption = 'Status'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 149
      Width = 718
      Height = 20
      object RLDraw3: TRLDraw
        Left = 0
        Top = -1
        Width = 718
        Height = 21
      end
      object RLDBText1: TRLDBText
        Left = 12
        Top = 1
        Width = 47
        Height = 17
        DataField = 'Codigo'
        DataSource = dsRel
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 90
        Top = 1
        Width = 40
        Height = 17
        DataField = 'Nome'
        DataSource = dsRel
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 586
        Top = 1
        Width = 39
        Height = 17
        DataField = 'Status'
        DataSource = dsRel
        Text = ''
      end
    end
  end
  object dsRel: TDataSource
    DataSet = cdsRel
    Left = 600
    Top = 256
  end
  object cdsRel: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 568
    Top = 256
    object cdsRelCodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Codigo'
    end
    object cdsRelNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object cdsRelCpf: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'Cpf'
      Size = 11
    end
    object cdsRelDtNascimento: TDateField
      DisplayLabel = 'Dt. Nascimento'
      FieldName = 'DtNascimento'
      EditMask = '!99/99/0000;1;_'
    end
    object cdsRelStatus: TStringField
      FieldName = 'Status'
      Size = 10
    end
  end
end
