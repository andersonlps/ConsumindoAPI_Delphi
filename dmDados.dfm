object DataModule1: TDataModule1
  Height = 480
  Width = 640
  object RESTClient1: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 112
    Top = 144
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 200
    Top = 144
  end
  object RESTResponse1: TRESTResponse
    Left = 288
    Top = 144
  end
end
