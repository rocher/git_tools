-------------------------------------------------------------------------------
--
--  Git Tools
--  Copyright (c) 2023 Francesc Rocher <francesc.rocher@gmail.com>
--  SPDX-License-Identifier: MIT
--
-------------------------------------------------------------------------------

package Git.Command is

   function Execute
     (Command : String; Show_Output : Boolean := True) return Boolean;
   --  Execute a git command, possibly with arguments, and returns True on
   --  success (e.g. "status", "pull --all --tags --force").

   function Execute
     (Directory : String; Command : String; Show_Output : Boolean := True)
      return Boolean;
   --  Execute a git command inside given directory, possibly with arguments,
   --  and returns True on success (e.g. "status", "pull --all --tags --force").

private

   function Setup return Boolean;

end Git.Command;
