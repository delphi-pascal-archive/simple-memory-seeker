unit memoryadreses;
{
  Made By SVSD_VAL
   Site   : SVSD.MirGames.Ru
   ICq    : 223-725-915
   Mail   : ValDIm_05@mail.ru / SVSD_VAL@SibNet.ru
   Jabber : svsd_val@Jabber.Sibnet.ru
}
{$Warnings off}
interface
uses windows;

type
  TMappedAddress  = Record
    Address, Size : Cardinal;
  end;

  TMemoryAdres = Record
     MemoryAddress : Cardinal;
            Value  : Int64;
            bType  : byte;
  end;

  TAddreses    = Object
    Address    : Array of TMemoryAdres;
    Procedure Add   ( Addres:Cardinal; Value,ByteType: Int64);
    Procedure Remove(id : Cardinal);
    Function  Get   (id : Cardinal):TMemoryAdres;
    Procedure Clear;
  end;

  TMemorySearcher = Class
   Private
    Mapped   : Array of TMappedAddress; // This holds all the info about the R/W memory blocks
    MapsCount: Integer;                 // The number of R/W blocks in Mapped
    Addreses : TAddreses;               // Our addreses in memory

    H_WND,
    H_PID,
    H_PROC   : LongWord;
    RW,
    Addreses_count : Cardinal;
    SeekTime       : Integer;


    Procedure OpenOrCloseProcess(Open:boolean);
    Procedure MapMemory(BufferSize : Integer; ByteType : Integer);

   Public
    Max,Pos  : Integer;
    Procedure AssignHandle(Handle: LongWord);

    Procedure AddAddres(addres:Cardinal; value, byteType: Int64);
    Procedure RemoveAddres(id : Integer);
    Procedure Clear;

    Function  SetAddresValue(Addres, ByteType : Cardinal; NewValue:int64):Boolean;
    Function  GetAddresValue(Addres, ByteType : Cardinal; var GetValue:int64):Boolean;
    Function  GetAddres(id:Cardinal):TMemoryAdres;

    Procedure FindValue(Value:Int64;ByteType:Byte; ProcessMessages:Pointer);
    Procedure SortFoundedValue(Value:Int64; ProcessMessages:Pointer);
    Property  AddresCount :cardinal read Addreses_count;

  end;


implementation

const
 Address_begin = $400000;
 Address_end   = $80000000;
 BufferSize    = 4096;

{ --------------------------------------------------------------------------- }
{ Addreses manager ---------------------------------------------------------- }
{ --------------------------------------------------------------------------- }
Procedure TAddreses.Add(addres:Cardinal; value, ByteType: Int64);
var i :integer;
begin
 I := Length(Address);
   SetLength(Address,I+1);
   Address[i].MemoryAddress := AddRes;
   Address[i].Value         := Value;
   Address[i].bType         := ByteType;
end;

Procedure TAddreses.Remove(id: Cardinal);
begin
if id > High(Address) then exit;
 Address[id] := Address[High(Address)];
      setlength(Address,High(Address));
end;

Function TAddreses.Get(id: Cardinal):TMemoryAdres;
begin
if id > High(Address) then exit;
 Result := Address[id];
end;

Procedure TAddreses.Clear;
begin
Address := nil;
end;

{ --------------------------------------------------------------------------- }
{ Memory Manager Our Searcher------------------------------------------------ }
{ --------------------------------------------------------------------------- }

Procedure TMemorySearcher.OpenOrCloseProcess(Open:boolean);
begin
  If Open then begin
    H_PROC := openprocess(process_all_access,false,H_PID);
  end else begin
    closehandle(H_Proc);
    h_proc := 0;
  end;
end;

Procedure TMemorySearcher.AssignHandle(Handle: LongWord);
begin
  If Handle = 0 then exit;

  H_WND := Handle;
  getwindowthreadprocessid(h_wnd, H_PID);
end;

Procedure TMemorySearcher.AddAddres(addres:Cardinal; value,ByteType: Int64);
begin
 addreses.Add(addres,value, ByteType);
end;

Procedure TMemorySearcher.RemoveAddres(id: Integer);
begin
 addreses.Remove(id);
end;

Function TMemorySearcher.GetAddres(id: Cardinal):TMemoryAdres;
begin
 Result := Addreses.Get(id);
end;


Procedure TMemorySearcher.Clear;
begin
  Addreses.Clear;
end;


Function TMemorySearcher.GetAddresValue(Addres, ByteType : Cardinal; var GetValue:int64):Boolean;
begin
Result := False;
    GetValue:=0;
    OpenOrCloseProcess(True);
    If (H_Proc <> 0 ) and
    readprocessmemory(H_Proc,Pointer( Addres ),@GetValue, ByteType ,rw ) then result:=True;
    OpenOrCloseProcess(False);
end;

Function TMemorySearcher.SetAddresValue(Addres, ByteType : Cardinal; NewValue:int64):Boolean;
begin
Result := False;
    OpenOrCloseProcess(True);
    If (H_Proc <> 0 ) and
    writeprocessmemory(H_Proc,Pointer( Addres ),@NewValue,ByteType,rw) then Result:=true;
    OpenOrCloseProcess(False);
end;

Procedure TMemorySearcher.FindValue(Value:Int64;ByteType:Byte; ProcessMessages:Pointer);
var
 i,i2      : integer;
 FoundValue: Int64;
 PM        : Procedure;
 Buffer    : Array of Byte;
begin
  PM := ProcessMessages;

  MapMemory(BufferSize, ByteType);
  SetLength(Buffer    , BufferSize + (ByteType - 1));

  OpenOrCloseProcess(True);

 SeekTime := gettickcount;
      Max := MapsCount;

    for i := 0 to MapsCount do
    begin
       ReadProcessMemory(H_Proc, Pointer(Mapped[ I ].Address), @Buffer[0], Mapped[i].Size, Rw);

       // Check for a match
       For i2 := 0 to buffersize - byteType -1 do
        begin
          FoundValue := 0;
          CopyMemory(@FoundValue, @Buffer[I2], ByteType);

         if FoundValue = Value then
          AddAddres(Mapped[ I ].Address + i2 ,FoundValue, ByteType);
        end;

        if (i mod 100 = 0) and (@PM <> nil) then PM;
        POS := i;
    end;


  SetLength(Buffer, 0 );
  Addreses_count:= Length(addreses.Address);

  OpenOrCloseProcess(False);

  SeekTime := gettickcount - SeekTime;

  if @PM <> nil then PM;
end;


Procedure TMemorySearcher.SortFoundedValue(Value:Int64;ProcessMessages:Pointer);
var
 i         : integer;
 FoundValue: Int64;
 PM        : Procedure;
 Buffer    : Array of Byte;
 Founded   : TAddreses;


begin
  PM := ProcessMessages;
  OpenOrCloseProcess(True);

 SeekTime := gettickcount;

  SetLength(Buffer  ,8);
  FillChar(buffer[0],8,0);

 for i := 0 to Length(Addreses.Address) - 1 do
 with Addreses do
 begin
      FoundValue:=0;

   ReadProcessMemory(H_Proc, Pointer(Address[i].MemoryAddress) , @Buffer[0], Address[i].bType, Rw);

        CopyMemory(@FoundValue, @Buffer[0], Address[i].bType);

   if FoundValue = Value then
      Founded.Add( Address[i].MemoryAddress , FoundValue ,Address[i].bType);

  if (i mod 100 = 0) and (@PM <> nil) then PM;

 end;
  SetLength(Buffer, 0 );

 Addreses.Clear;

 SetLength(Addreses.Address, Length(Founded.Address));
 Move(Founded.Address[0].MemoryAddress , Addreses.Address[0].MemoryAddress , Length(Founded.Address) * SizeOf(TMemoryAdres) );

 Addreses_count:= Length(addreses.Address);
 OpenOrCloseProcess(False);

  SeekTime := gettickcount - SeekTime;

end;


Procedure TMemorySearcher.MapMemory(BufferSize : Integer; ByteType : Integer);
var
  MBI       : MEMORY_BASIC_INFORMATION;
  dwAddress : Cardinal;
  Region    : Integer;
  Block     : Integer;
begin
  dwAddress := Address_begin;

  Finalize(Mapped);
           Mapped := nil;

  MapsCount := 0;

  H_Proc    := OpenProcess(PROCESS_QUERY_INFORMATION, False, H_PID);

  While (VirtualQueryEx(H_Proc, Pointer(dwAddress), MBI, SizeOf(MEMORY_BASIC_INFORMATION)) > 0)
        and (Integer(MBI.BaseAddress) + MBI.RegionSize < Address_end) do
  begin
    If (MBI.Protect = PAGE_READWRITE) and ((MBI.State = MEM_COMMIT) or (MBI.State = MEM_RESERVE)) Then
    begin
      Region := MBI.RegionSize;
      Block  := 0;

      Repeat
           If Block > 0 then
           MBI.BaseAddress := Pointer(Integer(MBI.BaseAddress) - (ByteType - 1));

           MapsCount := Length(Mapped);
           SetLength(Mapped, MapsCount+1);
           Mapped[MapsCount].Address := Integer(MBI.BaseAddress) + (MBI.RegionSize - Region);

           If Region <= BufferSize then
           begin
               if Block > 0 then Mapped[MapsCount].Size := Region + (ByteType - 1) else
                                 Mapped[MapsCount].Size := Region;
                  Region := 0;
           end
             else
            begin
              if Block > 0 then Mapped[MapsCount].Size := BufferSize + (ByteType - 1) else
                                Mapped[MapsCount].Size := BufferSize;
              inc(Block);
              Region := Region - BufferSize;
            end;
      Until Region = 0;

    end;

    Inc(dwAddress, MBI.RegionSize);
  end;

  CloseHandle(h_proc);
end;


end.
