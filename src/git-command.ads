-------------------------------------------------------------------------------
--
--  Git Tools
--  Copyright (c) 2023 Francesc Rocher <francesc.rocher@gmail.com>
--  SPDX-License-Identifier: MIT
--
-------------------------------------------------------------------------------

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Git.Command is

   type Argument_List is array (Positive range <>) of aliased Unbounded_String;

   function Execute (Command : aliased String) return Boolean;
   function Execute
     (Command : aliased String; Arguments : Argument_List) return Boolean;

private

   function Setup return Boolean;

end Git.Command;
