object Dm: TDm
  OldCreateOrder = False
  Height = 306
  Width = 534
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorHome = 'D:\Simus\source\Win32\Debug'
    Left = 320
    Top = 136
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=simus'
      'User_Name=postgres'
      'Password=123'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 248
    Top = 136
  end
end
