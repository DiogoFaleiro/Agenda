unit unitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Dialogs;

type
  TDM = class(TDataModule)
    Conexao: TFDConnection;
    tbContatos: TFDTable;
    dsContatos: TDataSource;
    tbContatosid: TFDAutoIncField;
    tbContatosnome: TStringField;
    tbContatosgrau: TStringField;
    tbContatoscelular: TStringField;
    tbContatosemail: TStringField;
    tbContatosbloqueado: TBooleanField;
    tbContatosdata: TDateTimeField;
    tbContatosobservacoes: TMemoField;
    sqlConsulta: TFDQuery;
    dsSqlConsulta: TDataSource;
    procedure sqlConsultaAfterInsert(DataSet: TDataSet);
    procedure sqlConsultaAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses unitPrincipal;

{$R *.dfm}

procedure TDM.sqlConsultaAfterInsert(DataSet: TDataSet);
begin

  // Pegando a data e a hora quando for gravar a informa��o
  tbContatosdata.Value := Now();

end;

procedure TDM.sqlConsultaAfterOpen(DataSet: TDataSet);
begin

  // Colocando m�scara em um campo sem adiciona-lo na query
  TNumericField(DataSet.FieldByName('celular')).EditMask := '!\(99\)00000-0000;1;_';

end;

end.
