with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Interfaces; use Interfaces;
with Base58; use Base58;
procedure Base58_Test is

  ---------------
  -- Serialize --
  ---------------
  function Serialize (Items : Byte_Array) return String is
    Output : Unbounded_String;
  begin
    Append (Output, "(");
    for I in Items'First .. Items'Last - 1 loop
      Append (Output, Unsigned_8'Image (Items (I))); Append (Output, ",");
    end loop;
    Append (Output, Unsigned_8'Image (Items (Items'Last))); Append (Output, " )");
    return To_String (Output);
  end;

  Example_Byte_Array : constant Byte_Array := (
     1 => 16#00#,  2 => 16#3C#,  3 => 16#17#,  4 => 16#6E#,  5 => 16#65#,
     6 => 16#9B#,  7 => 16#EA#,  8 => 16#0F#,  9 => 16#29#, 10 => 16#A3#,
    11 => 16#E9#, 12 => 16#BF#, 13 => 16#78#, 14 => 16#80#, 15 => 16#C1#,
    16 => 16#12#, 17 => 16#B1#, 18 => 16#B3#, 19 => 16#1B#, 20 => 16#4D#,
    21 => 16#C8#, 22 => 16#26#, 23 => 16#26#, 24 => 16#81#, 25 => 16#87#);
  Example_Base58 : constant String     := "16UjcYNBG9GTK4uq2f7yYEbuifqCzoLMGS";
  Encoded        : constant String     := To_String (Encode (Example_Byte_Array));
  Decoded        : constant Byte_Array := Decode (To_Encoded_String (Example_Base58));
begin
  Put_Line ("--------------");
  Put_Line ("-- ENCODING --");
  Put_Line ("--------------");
  Put_Line ("Expected : " & Example_Base58);
  Put_Line ("Actual   : " & Encoded);
  Put_Line ("--------------");
  Put_Line ("-- DECODING --");
  Put_Line ("--------------");
  Put_Line ("Expected : " & Serialize (Example_Byte_Array));
  Put_Line ("Actual   : " & Serialize (Decoded));
end;
