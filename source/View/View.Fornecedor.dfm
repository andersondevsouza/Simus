inherited frmCadastroFornecedor: TfrmCadastroFornecedor
  Caption = 'Cadastro de Fornecedor'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGrid
    TabOrder = 2
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Title.Caption = 'C'#243'digo'
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NomeFantasia'
        Title.Caption = 'Nome Fantasia'
        Width = 186
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RazaoSocial'
        Title.Caption = 'Razao Social'
        Width = 212
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cnpj'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Status'
        Visible = True
      end>
  end
  inherited pnBotoes: TPanel
    TabOrder = 0
  end
  inherited pnFiltro: TPanel
    TabOrder = 1
    inherited edtFiltro: TEdit
      OnChange = edtFiltroChange
    end
  end
  inherited pnCadastro: TPanel
    object Label1: TLabel
      Left = 10
      Top = 4
      Width = 76
      Height = 13
      Caption = 'Nome Fantasia'
    end
    object Label2: TLabel
      Left = 434
      Top = 44
      Width = 24
      Height = 13
      Caption = 'CNPJ'
    end
    object Label3: TLabel
      Left = 10
      Top = 44
      Width = 64
      Height = 13
      Caption = 'Raz'#227'o Social'
    end
    object edtNomeFantasia: TDBEdit
      Left = 10
      Top = 20
      Width = 615
      Height = 21
      DataField = 'NomeFantasia'
      DataSource = ds
      TabOrder = 0
    end
    object edtCnpj: TDBEdit
      Left = 434
      Top = 60
      Width = 127
      Height = 21
      DataField = 'Cnpj'
      DataSource = ds
      TabOrder = 2
    end
    object cbStatus: TDBCheckBox
      Left = 579
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Ativo'
      DataField = 'Status'
      DataSource = ds
      TabOrder = 3
      ValueChecked = 'Ativo'
      ValueUnchecked = 'Inativo'
    end
    object edtRazaoSocial: TDBEdit
      Left = 10
      Top = 60
      Width = 418
      Height = 21
      DataField = 'RazaoSocial'
      DataSource = ds
      TabOrder = 1
    end
  end
  inherited ds: TDataSource
    DataSet = cdsConsulta
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 80
    object cdsConsultaCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsConsultaNomeFantasia: TStringField
      FieldName = 'NomeFantasia'
      Size = 50
    end
    object cdsConsultaRazaoSocial: TStringField
      FieldName = 'RazaoSocial'
      Size = 50
    end
    object cdsConsultaCnpj: TStringField
      FieldName = 'Cnpj'
      Size = 14
    end
    object cdsConsultaStatus: TStringField
      FieldName = 'Status'
      Size = 10
    end
  end
end
