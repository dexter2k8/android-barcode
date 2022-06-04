program ProjectBarcode;

uses
  System.StartUpCopy,
  FMX.Forms,
  Barcode in 'Barcode.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
