unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    btnGetProduct: TButton;
    lblTitle: TLabel;
    imgProduct: TImage;
    procedure btnGetProductClick(Sender: TObject);
  private
    procedure LoadProductData;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.Net.HttpClient, System.JSON, Vcl.Imaging.jpeg;

{$R *.dfm}

procedure TForm1.btnGetProductClick(Sender: TObject);
begin
  LoadProductData;
end;

procedure TForm1.LoadProductData;
var
  httpClient: THTTPClient;
  response: IHTTPResponse;
  jsonResponse: TJSONObject;
  productsArray: TJSONArray;
  product: TJSONObject;
  productTitle, imageUrl: string;
  imageStream: TMemoryStream;
  jpg: TJPEGImage;
  jsonValue: TJSONValue;
begin
  httpClient := THTTPClient.Create;
  try
    // Chamada à API – altere a URL conforme necessário
    response := httpClient.Get('https://api.barcodelookup.com/v3/products?barcode=7894900011593&formatted=y&key=7ld3php4kegm0emtngihojxx47dque');

    if response.StatusCode = 200 then
    begin
      // Converte a resposta JSON para objeto
      jsonResponse := TJSONObject.ParseJSONValue(response.ContentAsString()) as TJSONObject;
      if Assigned(jsonResponse) then
      try
        // Obtém o array "products" do JSON
        jsonValue := jsonResponse.GetValue('products');
        if (jsonValue <> nil) and (jsonValue is TJSONArray) then
        begin
          productsArray := jsonValue as TJSONArray;
          if productsArray.Count > 0 then
          begin
            // Pega o primeiro produto do array
            product := productsArray.Items[0] as TJSONObject;
            productTitle := product.GetValue<string>('title');
            lblTitle.Caption := productTitle;

            // Obtém o array "images" e pega a primeira URL
            jsonValue := product.GetValue('images');
            if (jsonValue <> nil) and (jsonValue is TJSONArray) then
            begin
              productsArray := jsonValue as TJSONArray;
              if productsArray.Count > 0 then
              begin
                imageUrl := productsArray.Items[0].Value;
                // Baixa a imagem
                imageStream := TMemoryStream.Create;
                try
                  response := httpClient.Get(imageUrl, imageStream);
                  if response.StatusCode = 200 then
                  begin
                    imageStream.Position := 0;
                    jpg := TJPEGImage.Create;
                    try
                      jpg.LoadFromStream(imageStream);
                      imgProduct.Picture.Assign(jpg);
                    finally
                      jpg.Free;
                    end;
                  end;
                finally
                  imageStream.Free;
                end;
              end;
            end;
          end;
        end;
      finally
        jsonResponse.Free;
      end;
    end
    else
      ShowMessage('Erro ao acessar a API. Código: ' + response.StatusCode.ToString);
  finally
    httpClient.Free;
  end;
end;

end.

