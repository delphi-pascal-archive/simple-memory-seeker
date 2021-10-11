unit Unit1;
{
  Made By SVSD_VAL
   Site   : SVSD.MirGames.Ru
   ICq    : 223-725-915
   Mail   : ValDIm_05@mail.ru / SVSD_VAL@SibNet.ru
   Jabber : svsd_val@Jabber.Sibnet.ru
}
{$Warnings off}
{$hints on}
interface

uses
  Windows, SysUtils, Classes, Forms,
    Menus, ComCtrls, Controls, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet2   : TTabSheet;
    TabSheet1   : TTabSheet;

    Memo1       : TMemo;

    Panel1      : TPanel;
    Panel2      : TPanel;
    Panel3      : TPanel;
    Panel4      : TPanel;
    FindButton1 : TButton;
    SieveButton2: TButton;
    SetButton3  : TButton;
    ReadButton4 : TButton;

    ProgressBar1: TProgressBar;

    Label1      : TLabel;
    Label2      : TLabel;
    Label3      : TLabel;
    Label4      : TLabel;
    Label5      : TLabel;

    Edit1       : TEdit;
    AddressEdit : TEdit;
    ValueEdit   : TEdit;

    Timer1      : TTimer;
    GroupBox1   : TGroupBox;

    ByteBox     : TComboBox;
    ProcessBox  : TComboBox;
    FindByteType: TComboBox;
    AddToList   : TCheckBox;

    ListBox2    : TListBox;
    ListBox3    : TListBox;
    procedure FormCreate        (Sender: TObject);

    procedure FindButton1Click  (Sender: TObject);
    procedure SieveButton2Click (Sender: TObject);
    procedure SetButton3Click   (Sender: TObject);
    procedure ReadButton4Click  (Sender: TObject);

    procedure ListBox2DblClick  (Sender: TObject);
    procedure ListBox3Click     (Sender: TObject);
    procedure ListBox3KeyDown   (Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure Timer1Timer       (Sender: TObject);
    procedure ProcessBoxDropDown(Sender: TObject);
  private
    { Private declarations ? }
  public
    { Public declarations ? }
  end; 

var
  Form1: TForm1;

implementation
uses memoryadreses;
{$R *.dfm}

var
  Mem : TMemorySearcher;
  Proc: Array of record
        Name   : String;
        Handle : LongWord;
  end;

  Founded,
  InList      : TAddreses;

Procedure GetProcesses;
VAR
Wnd : hWnd;
buff: ARRAY [0..127] OF Char;
  i : integer;
begin
  with form1 do
  begin
    ProcessBox.Clear;
    Proc := nil;
    Wnd  := GetWindow(Handle, gw_HWndFirst);

    WHILE Wnd <> 0 DO BEGIN {Не показываем:}
    IF (Wnd <> Application.Handle) AND {-Собственное окно}
              IsWindowVisible(Wnd) AND {-Невидимые окна}
    (GetWindow(Wnd, gw_Owner) = 0) AND {-Дочернии окна}
    (GetWindowText(Wnd, buff, sizeof(buff)) <> 0) {-Окна без заголовков}
         THEN BEGIN
            GetWindowText(Wnd, buff, sizeof(buff));
            I := Length(Proc);
            SetLength(Proc, I + 1 );
            Proc[i].Name   := StrPas(buff);
            Proc[i].Handle := Wnd;

           ProcessBox.Items.Add(Proc[i].Name);
          END;
      Wnd := GetWindow(Wnd, gw_hWndNext);
      END;
    ProcessBox.ItemIndex := 0;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Mem := TMemorySearcher.Create;
     GetProcesses;
end;

procedure xUPdate;
begin
    Application.ProcessMessages;
    Form1.ProgressBar1.max      := mem.Max;
    Form1.ProgressBar1.Position := mem.Pos;
end;

////
Procedure UpdateMemoryList;
var
    i : integer;
begin
     Form1.ListBox2.Clear;
     SetLength ( Founded.Address , Mem.AddresCount );
     for i := 0 to mem.AddresCount-1 do
     with Founded do
     begin
      Address[i] := Mem.getaddres(i);
      if Form1.AddToList.Checked then
         Form1.ListBox2.Items.Add ( IntToStr( Address[i].MemoryAddress) + ' | ' + IntToStr( Address[i].Value ));
     end;
     Form1.Label1.Caption := 'Founded: '+ inttostr(mem.AddresCount);
end;

Function GetByteType(I:Integer):Integer;
begin case i of
 0 : Result := 1; 1 : Result := 2; 2 : Result := 4; else Result:=4;
 end;
end;

Function GetIDType(I:Integer):Integer;
begin case i of
 0 : Result := 0; 2 : Result := 1; 4 : Result := 2; else Result:= 2;
 end;
end;


////
procedure TForm1.FindButton1Click(Sender: TObject);
begin
     if ProcessBox.ItemIndex <0 then exit;
     mem.Clear;
     mem.AssignHandle( Proc [ ProcessBox.ItemIndex ].Handle  );
     mem.FindValue( StrToIntDef(Edit1.Text,0), GetByteType(FindByteType.ItemIndex), @xUpdate );
     UpdateMemoryList;
end;

////
procedure TForm1.SieveButton2Click(Sender: TObject);
var b:boolean;
begin
     if ProcessBox.ItemIndex <0 then exit;
     mem.SortFoundedValue( StrToIntDef(Edit1.Text,0), @xUpdate );

     b := Form1.AddToList.Checked;
     Form1.AddToList.Checked := true;
        UpdateMemoryList;
     Form1.AddToList.Checked := b;
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
var i :integer;
begin
 i := ListBox2.ItemIndex;
     if i <0 then exit;

     InList.Add(Founded.Address[ I ].MemoryAddress , Founded.Address[ I ].Value , Founded.Address[ I ].bType );

     ListBox3.Clear;
     for i := 0 to Length(InList.Address) -1 do
     begin
     ListBox3.Items.Add( IntToStr( InList.Address[ I ].MemoryAddress) + ' | '+
                         IntToStr( InList.Address[ I ].Value) );
     end;

end;

procedure TForm1.ListBox3Click(Sender: TObject);
begin
 AddressEdit.Text := IntToStr( InList.Address[ ListBox3.ItemIndex ].MemoryAddress );
 ValueEdit.Text   := IntToStr( InList.Address[ ListBox3.ItemIndex ].Value );
 ByteBox.ItemIndex:= GetIDType(InList.Address[ ListBox3.ItemIndex ].bType);
end;

procedure TForm1.SetButton3Click(Sender: TObject);
begin
  mem.SetAddresValue( StrToIntDef(AddressEdit.Text,0) ,GetByteType(ByteBox.ItemIndex), StrToIntDef(ValueEdit.Text,0) );
end;

procedure TForm1.ReadButton4Click(Sender: TObject);
var i : int64;
begin
  mem.GetAddresValue( StrToIntDef(AddressEdit.Text,0) ,GetByteType(ByteBox.ItemIndex), i );
  ValueEdit.Text := IntToStr(i);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
VAr I :Integer;
begin
     for i := 0 to Length(InList.Address) -1 do
     begin
     mem.GetAddresValue( InList.Address[i].MemoryAddress ,InList.Address[i].BType, InList.Address[i].Value );
     ListBox3.Items.Strings[i] :=
                         IntToStr( InList.Address[ I ].MemoryAddress) + ' | '+
                         IntToStr( InList.Address[ I ].Value) ;
     end;
end;

procedure TForm1.ProcessBoxDropDown(Sender: TObject);
begin
 GetProcesses;
end;

procedure TForm1.ListBox3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_Insert:
    if AddressEdit.Text <> '' then
      begin
       InList.Add( StrToIntDef(AddressEdit.Text,0) , StrToIntDef(ValueEdit.Text,0) , GetByteType(ByteBox.ItemIndex) );
       ListBox3.Items.Add( AddressEdit.Text + ' | '+ ValueEdit.Text );
      end;
    VK_Delete:
        if ListBox3.ItemIndex <>-1 then
        begin
                   InList.Remove(ListBox3.ItemIndex);
           ListBox3.Items.Delete(ListBox3.ItemIndex);
        end;
    end;

end;

end.
