unit unitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBMemo1: TDBMemo;
    Label4: TLabel;
    Label5: TLabel;
    DBText1: TDBText;
    DBGrid1: TDBGrid;
    txtbusca: TEdit;
    Label6: TLabel;
    DBComboBox1: TDBComboBox;
    Label7: TLabel;
    DBEdit3: TDBEdit;
    DBNavigator2: TDBNavigator;
    lblConsulta: TLabel;
    btconsultar: TButton;
    opcoes: TRadioGroup;
    procedure opcoesClick(Sender: TObject);
    procedure btconsultarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses unitDM;

procedure TForm1.btconsultarClick(Sender: TObject);
begin

  DM.sqlConsulta.Close;
  DM.sqlConsulta.SQL.Clear;

  if (opcoes.ItemIndex = 0) then
    begin
      DM.sqlConsulta.SQL.Add('select * from contatos where nome = :pConsulta');
      DM.sqlConsulta.ParamByName('pConsulta').AsString := txtBusca.Text;
    end;

  if (opcoes.ItemIndex = 1) then
    begin
      DM.sqlConsulta.SQL.Add('select * from contatos where celular = :pConsulta');
      DM.sqlConsulta.ParamByName('pConsulta').AsString := txtBusca.Text;
    end;

  DM.sqlConsulta.Open;

end;

procedure TForm1.opcoesClick(Sender: TObject);
begin

  if (opcoes.ItemIndex = 0) then
    begin
      lblConsulta.Caption := 'Digite o Nome';
    end;

  if (opcoes.ItemIndex = 1) then
    begin
      lblConsulta.Caption := 'Digite o Celular';
    end;

end;

end.
