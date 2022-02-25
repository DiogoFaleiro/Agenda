unit unitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
NewTypeNav = class( TDbNavigator );

type
  TForm1 = class(TForm)
    Label1: TLabel;
    editnome: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    checkbloq: TDBCheckBox;
    menoobs: TDBMemo;
    Label4: TLabel;
    Label5: TLabel;
    DBText1: TDBText;
    gridquery: TDBGrid;
    Label6: TLabel;
    combgrau: TDBComboBox;
    Label7: TLabel;
    editemail: TDBEdit;
    DBNavigator2: TDBNavigator;
    lblConsulta: TLabel;
    btconsultar: TButton;
    opcoes: TRadioGroup;
    txtbusca: TMaskEdit;
    editcel: TDBEdit;
    procedure opcoesClick(Sender: TObject);
    procedure btconsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
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
  // Configurando a query de consulta ao banco de dados
  DM.sqlConsulta.Close;
  DM.sqlConsulta.SQL.Clear;

  if (opcoes.ItemIndex = 0) then
    begin
      DM.sqlConsulta.SQL.Add('select * from contatos where nome LIKE :pConsulta');
      DM.sqlConsulta.ParamByName('pConsulta').AsString := txtbusca.Text+'%';
    end;

  if (opcoes.ItemIndex = 1) then
    begin
      DM.sqlConsulta.SQL.Add('select * from contatos where celular LIKE :pConsulta');
      DM.sqlConsulta.ParamByName('pConsulta').AsString := txtbusca.Text+'%';
    end;

  DM.sqlConsulta.Open;

end;
 // Fun��o para centralizar a mensagem para o usu�rio
function MessageDlg(const AOwner: TForm; const Msg: string; DlgType: TMsgDlgType;
Buttons: TMsgDlgButtons; HelpCtx: Integer = 0): Integer;
  begin
    with CreateMessageDialog(Msg, DlgType, Buttons) do
     try
       Left := AOwner.Left + (AOwner.Width - Width) div 2;
       Top := AOwner.Top + (AOwner.Height - Height) div 2;
        Result := ShowModal;
      finally
      Free;
      end
  end;

procedure TForm1.DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
begin
  // Controle de mensagens ao clicar nos bot�es do navigator
  case Button of
    nbFirst: ;
    nbPrior: ;
    nbNext: ;
    nbLast: ;
    nbInsert: ;
    nbDelete: If MessageDlg(Self, 'Excluir o Registro?',mtWarning,[mbYes,mbNo],0) = mrYes Then
              dm.sqlConsulta.Delete;
    nbEdit: ;
    nbPost: MessageDlg(Self, 'Cadastro gravado com sucesso!', mtInformation, [mbOK]);
    nbCancel: ;
    nbRefresh: ;
    nbApplyUpdates: ;
    nbCancelUpdates: ;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Modificando os bot�es do navigator para este projeto
  NewTypeNav( DBNavigator2 ).Buttons[nbInsert].Glyph.LoadFromFile('D:\OneDrive\BKPDELL\DESKTOP\CURSOS\YOUTUBE\DELPHI\AGENDA\Agenda\Project_agenda\Icons\add.bmp');
    NewTypeNav( DBNavigator2 ).Buttons[nbDelete].Glyph.LoadFromFile('D:\OneDrive\BKPDELL\DESKTOP\CURSOS\YOUTUBE\DELPHI\AGENDA\Agenda\Project_agenda\Icons\delete.bmp');
      NewTypeNav( DBNavigator2 ).Buttons[nbEdit].Glyph.LoadFromFile('D:\OneDrive\BKPDELL\DESKTOP\CURSOS\YOUTUBE\DELPHI\AGENDA\Agenda\Project_agenda\Icons\edit.bmp');
        NewTypeNav( DBNavigator2 ).Buttons[nbFirst].Glyph.LoadFromFile('D:\OneDrive\BKPDELL\DESKTOP\CURSOS\YOUTUBE\DELPHI\AGENDA\Agenda\Project_agenda\Icons\first.bmp');
          NewTypeNav( DBNavigator2 ).Buttons[nbPrior].Glyph.LoadFromFile('D:\OneDrive\BKPDELL\DESKTOP\CURSOS\YOUTUBE\DELPHI\AGENDA\Agenda\Project_agenda\Icons\prior.bmp');
            NewTypeNav( DBNavigator2 ).Buttons[nbNext].Glyph.LoadFromFile('D:\OneDrive\BKPDELL\DESKTOP\CURSOS\YOUTUBE\DELPHI\AGENDA\Agenda\Project_agenda\Icons\next.bmp');
              NewTypeNav( DBNavigator2 ).Buttons[nbLast].Glyph.LoadFromFile('D:\OneDrive\BKPDELL\DESKTOP\CURSOS\YOUTUBE\DELPHI\AGENDA\Agenda\Project_agenda\Icons\last.bmp');
                NewTypeNav( DBNavigator2 ).Buttons[nbPost].Glyph.LoadFromFile('D:\OneDrive\BKPDELL\DESKTOP\CURSOS\YOUTUBE\DELPHI\AGENDA\Agenda\Project_agenda\Icons\post.bmp');
                  NewTypeNav( DBNavigator2 ).Buttons[nbCancel].Glyph.LoadFromFile('D:\OneDrive\BKPDELL\DESKTOP\CURSOS\YOUTUBE\DELPHI\AGENDA\Agenda\Project_agenda\Icons\cancel.bmp');
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
// Passando pelos edit's com enter
if Key = VK_RETURN then
   perform(WM_NEXTDLGCTL,0,0);

end;

procedure TForm1.opcoesClick(Sender: TObject);
begin
  // Identificando qual dos filtros est� marcado e mudando o label

  if (opcoes.ItemIndex = 0) then
    begin

      btconsultar.Hide;
      lblConsulta.Caption := 'Pesquisa enquanto digita o nome';
      txtbusca.EditMask := '';
      txtbusca.Width := 242;
      txtbusca.Clear;

    end;

  if (opcoes.ItemIndex = 2) then
    begin

      btconsultar.Show;
      lblConsulta.Caption := 'Digite o Nome';
      txtbusca.EditMask := '';
      txtbusca.Width := 242;
      txtbusca.Clear;

    end;

  if (opcoes.ItemIndex = 1) then
    begin

      btconsultar.Show;
      lblConsulta.Caption := 'Digite o Celular';
      txtbusca.EditMask := '!\(99\)00000-0000;1;_';
      txtbusca.Width := 113;
      txtbusca.Clear;

    end;

end;

end.
