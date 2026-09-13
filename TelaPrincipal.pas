unit TelaPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  REST.Client, REST.Types, System.JSON, System.NetEncoding, dmDados;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    edtPais: TEdit;
    btnConsultar: TButton;
    lblNomeOficial: TLabel;
    lblCapital: TLabel;
    lblRegiao: TLabel;
    lblPopulacao: TLabel;
    lblMoeda: TLabel;
    lblPais: TLabel;
    procedure btnConsultarClick(Sender: TObject);
  private
    procedure LimparCampos;
    procedure ConsultarPais(const ANomePais: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.LimparCampos;
begin
  lblNomeOficial.Caption := 'Nome Oficial: -';
  lblCapital.Caption     := 'Capital: -';
  lblRegiao.Caption      := 'Região: -';
  lblPopulacao.Caption   := 'População: -';
  lblMoeda.Caption       := 'Moeda: -';
end;

procedure TForm1.btnConsultarClick(Sender: TObject);
begin
  if Trim(edtPais.Text) = '' then
  begin
    ShowMessage('Por favor, informe o nome do país.');
    edtPais.SetFocus;
    Exit;
  end;

  ConsultarPais(Trim(edtPais.Text));
end;

procedure TForm1.ConsultarPais(const ANomePais: string);
var
  JSONArray: TJSONArray;
  PaisObj: TJSONObject;
  CurrenciesArray: TJSONArray;
  MoedaObj: TJSONObject;
  NomeOficial, Capital, Regiao, Populacao, Moeda: string;
begin
  LimparCampos;

  DataModule1.RESTClient1.BaseURL := 'https://countries.dev/name/' + TNetEncoding.URL.Encode(ANomePais);
  DataModule1.RESTRequest1.Client := DataModule1.RESTClient1;
  DataModule1.RESTRequest1.Response := DataModule1.RESTResponse1;
  DataModule1.RESTRequest1.Method := TRESTRequestMethod.rmGET;

  try
    DataModule1.RESTRequest1.Execute;

    if DataModule1.RESTResponse1.StatusCode <> 200 then
    begin
      ShowMessage('País não encontrado,verifique o nome digitado.');
      Exit;
    end;

    JSONArray := TJSONObject.ParseJSONValue(DataModule1.RESTResponse1.Content) as TJSONArray;
    try
      if (JSONArray = nil) or (JSONArray.Count = 0) then
      begin
        ShowMessage('Nenhum dado encontrado para o país informado.');
        Exit;
      end;

      PaisObj := JSONArray.Items[0] as TJSONObject;

      NomeOficial := PaisObj.GetValue<string>('name', 'N/A');
      Capital     := PaisObj.GetValue<string>('capital', 'N/A');
      Regiao      := PaisObj.GetValue<string>('region', 'N/A');
      Populacao   := FormatFloat('#,##0', PaisObj.GetValue<Int64>('population', 0));

      Moeda := 'N/A';
      if PaisObj.TryGetValue<TJSONArray>('currencies', CurrenciesArray) and (CurrenciesArray.Count > 0) then
      begin
        MoedaObj := CurrenciesArray.Items[0] as TJSONObject;
        Moeda := MoedaObj.GetValue<string>('name', 'N/A');
      end;

      lblNomeOficial.Caption := 'Nome Oficial: ' + NomeOficial;
      lblCapital.Caption     := 'Capital: ' + Capital;
      lblRegiao.Caption      := 'Região: ' + Regiao;
      lblPopulacao.Caption   := 'População: ' + Populacao;
      lblMoeda.Caption       := 'Moeda: ' + Moeda;

    finally
      JSONArray.Free;
    end;

  except
    on E: Exception do
      ShowMessage('Ocorreu um erro ao consultar a API: ' + E.Message);
  end;
end;

end.
