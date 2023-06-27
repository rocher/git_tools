-------------------------------------------------------------------------------
--
--  Git Tools
--  Copyright (c) 2023 Francesc Rocher <francesc.rocher@gmail.com>
--  SPDX-License-Identifier: MIT
--
-------------------------------------------------------------------------------

pragma Ada_2022;

with Simple_Logging;

with GNAT.OS_Lib;
use all type GNAT.OS_Lib.String_Access;

package body Git.Command is

   package Log renames Simple_Logging;

   Git_Cmd : GNAT.OS_Lib.String_Access;

   -------------
   -- Execute --
   -------------

   function Execute (Command : String) return Boolean is
      Status : Integer;
      Args   : GNAT.OS_Lib.Argument_List_Access;
   begin
      if not Setup then
         return False;
      end if;

      Args   := GNAT.OS_Lib.Argument_String_To_List (Command);
      Status := GNAT.OS_Lib.Spawn (Git_Cmd.all, Args.all);
      GNAT.OS_Lib.Free (Args);
      return (Status = 0);
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
