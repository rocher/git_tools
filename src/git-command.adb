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

   function Execute (Command : aliased String) return Boolean is
      Args   : GNAT.OS_Lib.Argument_List (1 .. 1);
      Status : Integer;
   begin
      if not Setup then
         return False;
      end if;

      Args (1) := Command'Unrestricted_Access;
      Status   := GNAT.OS_Lib.Spawn (Git_Cmd.all, Args);
      return (Status = 0);
   end Execute;

   -------------
   -- Execute --
   -------------

   function Execute
     (Command : aliased String; Arguments : Argument_List) return Boolean
   is
      Args : GNAT.OS_Lib.Argument_List (1 .. 1 + Arguments'Length);
      I, Status : Integer;
   begin
      if not Setup then
         return False;
      end if;

      Args (1) := Command'Unrestricted_Access;

      I := 2;
      for Argument of Arguments loop
         Args (I) := To_String (Argument)'Unrestricted_Access;
         I        := @ + 1;
      end loop;
      Status := GNAT.OS_Lib.Spawn (Git_Cmd.all, Args);
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
