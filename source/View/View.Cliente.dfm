inherited frmCadastroCliente: TfrmCadastroCliente
  Caption = 'Cadastro de Clientes'
  ClientHeight = 335
  OnCreate = FormCreate
  ExplicitHeight = 364
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGrid
    Height = 138
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 318
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cpf'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DtNascimento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Status'
        Width = 50
        Visible = True
      end>
  end
  object DBEdit2: TDBEdit [1]
    Left = 3
    Top = 248
    Width = 118
    Height = 21
    DataSource = ds
    TabOrder = 1
  end
  object DBEdit3: TDBEdit [2]
    Left = 127
    Top = 248
    Width = 118
    Height = 21
    DataSource = ds
    TabOrder = 2
  end
  inherited pnBotoes: TPanel
    TabOrder = 3
  end
  inherited pnFiltro: TPanel
    TabOrder = 4
    inherited edtFiltro: TEdit
      OnChange = edtFiltroChange
    end
  end
  inherited pnCadastro: TPanel
    Top = 232
    Height = 100
    TabOrder = 5
    ExplicitTop = 232
    ExplicitHeight = 100
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
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object Label3: TLabel
      Left = 143
      Top = 44
      Width = 78
      Height = 13
      Caption = 'Dt. Nascimento'
    end
    object edtNome: TDBEdit
      Left = 10
      Top = 20
      Width = 615
      Height = 21
      DataField = 'Nome'
      DataSource = ds
      TabOrder = 0
    end
    object edtCpf: TDBEdit
      Left = 10
      Top = 60
      Width = 127
      Height = 21
      DataField = 'Cpf'
      DataSource = ds
      TabOrder = 1
    end
    object edtDtNascimento: TDBEdit
      Left = 143
      Top = 60
      Width = 127
      Height = 21
      DataField = 'DtNascimento'
      DataSource = ds
      TabOrder = 2
    end
    object cbStatus: TDBCheckBox
      Left = 281
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
  end
  inherited ds: TDataSource
    DataSet = cdsConsulta
    Left = 448
    Top = 144
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 144
    object cdsConsultaCodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Codigo'
    end
    object cdsConsultaNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object cdsConsultaCpf: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'Cpf'
      Size = 11
    end
    object cdsConsultaDtNascimento: TDateField
      DisplayLabel = 'Dt. Nascimento'
      FieldName = 'DtNascimento'
      EditMask = '!99/99/0000;1;_'
    end
    object cdsConsultaStatus: TStringField
      FieldName = 'Status'
      Size = 10
    end
  end
end
