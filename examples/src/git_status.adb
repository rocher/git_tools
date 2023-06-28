with Ada.Directories;
with Git.Command;
with Text_IO; use Text_IO;

procedure Git_Status is
   Result : Boolean;
begin
   Put_Line ("-- GIT STATUS (Show_Output)");
   Result := Git.Command.Execute ("status");
   Put_Line ("-- " & Result'Image & ASCII.LF);

   Put_Line ("-- GIT STATUS (no Show_Output)");
   Result := Git.Command.Execute ("status", False);
   Put_Line ("-- " & Result'Image & ASCII.LF);

   Put_Line ("-- GIT REMOTE (dir = ../../euler_tools/)");
   Put_Line ("-- CWD = " & Ada.Directories.Current_Directory);
   Result := Git.Command.Execute ("../../euler_tools/", "remote -v");
   Put_Line ("-- CWD = " & Ada.Directories.Current_Directory);
   Put_Line ("-- " & Result'Image & ASCII.LF);

end Git_Status;
