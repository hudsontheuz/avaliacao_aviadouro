program AvaliacaoAviarioTests;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  DUnitX.TestFramework;

var
  Runner: ITestRunner;
  Results: IRunResults;

begin
  try
    TDUnitX.CheckCommandLine;

    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;

    Results := Runner.Execute;

    if Results.AllPassed then
      System.ExitCode := 0
    else
      System.ExitCode := 1;

  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      System.ExitCode := 1;
    end;
  end;
end.

