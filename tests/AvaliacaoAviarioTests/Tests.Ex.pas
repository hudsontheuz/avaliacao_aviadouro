unit Tests.Ex;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TExTests = class
  public
    [Test]
    procedure TesteSimples;
  end;

implementation

procedure TExTests.TesteSimples;
begin
  Assert.AreEqual(4, 2 + 2);
end;

initialization
  TDUnitX.RegisterTestFixture(TExTests);

end.

