inherited frmCadastroProduto: TfrmCadastroProduto
  Caption = 'Cadastro de Produto'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Title.Caption = 'Descri'#231#227'o'
        Width = 390
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PrecoUnitario'
        Title.Caption = 'Pre'#231'o Unit'#225'rio'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Status'
        Visible = True
      end>
  end
  inherited pnCadastro: TPanel
    object Label1: TLabel
      Left = 10
      Top = 4
      Width = 30
      Height = 13
      Caption = 'Nome'
    end
    object Label2: TLabel
      Left = 10
      Top = 44
      Width = 73
      Height = 13
      Caption = 'Pre'#231'o Unit'#225'rio'
    end
    object Label3: TLabel
      Left = 146
      Top = 44
      Width = 59
      Height = 13
      Caption = 'Fornecedor'
    end
    object edtNome: TDBEdit
      Left = 10
      Top = 20
      Width = 615
      Height = 21
      DataField = 'Descricao'
      DataSource = ds
      TabOrder = 0
    end
    object edtPreco: TDBEdit
      Left = 10
      Top = 60
      Width = 127
      Height = 21
      DataField = 'PrecoUnitario'
      DataSource = ds
      TabOrder = 1
    end
    object cbStatus: TDBCheckBox
      Left = 573
      Top = 64
      Width = 52
      Height = 17
      Caption = 'Ativo'
      DataField = 'Status'
      DataSource = ds
      TabOrder = 3
      ValueChecked = 'Ativo'
      ValueUnchecked = 'Inativo'
    end
    object dblcFornecedor: TDBLookupComboBox
      Left = 146
      Top = 60
      Width = 417
      Height = 21
      DataField = 'Fornecedor'
      DataSource = ds
      KeyField = 'Codigo'
      ListField = 'NomeFantasia'
      ListSource = dsFornecedor
      TabOrder = 2
    end
  end
  inherited ds: TDataSource
    DataSet = cdsConsulta
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 384
    Top = 80
    object cdsConsultaCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsConsultaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object cdsConsultaPrecoUnitario: TFloatField
      FieldName = 'PrecoUnitario'
      DisplayFormat = ',#0.00'
    end
    object cdsConsultaFornecedor: TIntegerField
      FieldName = 'Fornecedor'
    end
    object cdsConsultaStatus: TStringField
      FieldName = 'Status'
      Size = 10
    end
  end
  object dsFornecedor: TDataSource
    DataSet = cdsFornecedor
    Left = 312
    Top = 168
  end
  object cdsFornecedor: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 168
    object cdsFornecedorCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsFornecedorNomeFantasia: TStringField
      FieldName = 'NomeFantasia'
      Size = 50
    end
  end
end
