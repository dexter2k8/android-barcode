unit Barcode;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.platform,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, fmx.helpers.android,
  androidapi.JNI.GraphicsContentViewText, androidapi.jni.JavaTypes,
  Androidapi.Helpers;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Image1: TImage;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    ClipService: IFMXClipboardService;
    Elapsed: integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
uses Androidapi.NativeActivity;

//Instale o apk Barcode Scanner do ZXing Team na Google Play.

procedure TForm1.Button1Click(Sender: TObject);
var
  Intent : JIntent;
begin
  if assigned(ClipService) then
  begin
    clipservice.SetClipboard('nil');
     intent := tjintent.Create;
    intent.setAction(stringtojstring('com.google.zxing.client.android.SCAN'));
    SharedActivity.startActivityForResult(intent,0);
    Elapsed := 0;
    Timer1.Enabled := True;
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Label1.Text.Empty;
  ClipService.SetClipboard('nil');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(ClipService)) then
    ClipService := nil;

  Elapsed := 0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if (ClipService.GetClipboard.ToString <> 'nil') then
  begin
    timer1.Enabled := false;
    Elapsed := 0;
    Label1.Text := ClipService.GetClipboard.ToString;
  end
  else
    begin
      if Elapsed > 9 then
        begin
          timer1.Enabled := false;
          Elapsed := 0;
        end
      else
          Elapsed := Elapsed +1;
    end;
end;

end.
