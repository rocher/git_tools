with Git.Command;
with Text_IO; use Text_IO;

procedure Git_Status is
begin
   Text_IO.Put_Line (Git.Command.Execute ("status")'Image);
end Git_Status;
