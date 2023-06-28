-------------------------------------------------------------------------------
--
--  Git Tools
--  Copyright (c) 2023 Francesc Rocher <francesc.rocher@gmail.com>
--  SPDX-License-Identifier: MIT
--
-------------------------------------------------------------------------------

with Ada.Directories;
with Simple_Logging;

with GNAT.OS_Lib;
use all type GNAT.OS_Lib.String_Access;

package body Git.Command is

   package Log renames Simple_Logging;

   Git_Cmd : GNAT.OS_Lib.String_Access;

   -------------
   -- Execute --
   -------------

   function Execute
     (Command : String; Show_Output : Boolean := True) return Boolean
   is
      Return_Code : Integer;
      Args        : GNAT.OS_Lib.Argument_List_Access;
   begin
      if not Setup then
         return False;
      end if;

      Args := GNAT.OS_Lib.Argument_String_To_List (Command);
      if not Show_Output then
         declare
            Success : Boolean;
         begin
            GNAT.OS_Lib.Spawn
              (Git_Cmd.all, Args.all, "/dev/null", Success, Return_Code);
         end;
      else
         Return_Code := GNAT.OS_Lib.Spawn (Git_Cmd.all, Args.all);
      end if;
      GNAT.OS_Lib.Free (Args);
      return (Return_Code = 0);
   end Execute;

   -------------
   -- Execute --
   -------------

   function Execute
     (Directory : String; Command : String; Show_Output : Boolean := True)
      return Boolean
   is
      Success : Boolean;
      Old_CWD : constant String := Ada.Directories.Current_Directory;
   begin
      Ada.Directories.Set_Directory (Directory);
      Success := Execute (Command, Show_Output);
      Ada.Directories.Set_Directory (Old_CWD);
      return Success;

   exception
      when Ada.Directories.Name_Error =>
         return False;
      when Ada.Directories.Use_Error  =>
         return False;
   end Execute;

   -----------
   -- Setup --
   -----------

   function Setup return Boolean is
   begin
      if Git_Cmd = null then
         Git_Cmd := GNAT.OS_Lib.Locate_Exec_On_Path ("git");
         if Git_Cmd = null then
            Log.Error ("'git' cannot be found in PATH");
            return False;
         end if;
      end if;
      return True;
   end Setup;

end Git.Command;
