object frmChamaRelVendas: TfrmChamaRelVendas
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Vendas por Cliente'
  ClientHeight = 88
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 98
    Height = 13
    Caption = 'Selecione o Cliente'
  end
  object dblcCliente: TDBLookupComboBox
    Left = 8
    Top = 27
    Width = 461
    Height = 21
    KeyField = 'Codigo'
    ListField = 'Nome'
    ListSource = ds
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 192
    Top = 56
    Width = 99
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 336
    Top = 47
    object cdsClienteCodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Codigo'
    end
    object cdsClienteNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object cdsClienteCpf: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'Cpf'
      Size = 11
    end
    object cdsClienteDtNascimento: TDateField
      DisplayLabel = 'Dt. Nascimento'
      FieldName = 'DtNascimento'
      EditMask = '!99/99/0000;1;_'
    end
    object cdsClienteStatus: TStringField
      FieldName = 'Status'
      Size = 10
    end
  end
  object ds: TDataSource
    AutoEdit = False
    DataSet = cdsCliente
    Left = 367
    Top = 47
  end
end
