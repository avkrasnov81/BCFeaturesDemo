dotnet
{
    assembly(System)
    {
        type(System.Text.RegularExpressions.Regex; RegExp) { }
        type(System.Text.RegularExpressions.RegexOptions; RegexOption) { }
    }
}

pageextension 50101 "ContantListCorrectedEmailExt" extends "Contact List"
{
    layout
    {
        addafter("E-Mail")
        {
            field("Correct Email"; CorrectEmail)
            {
                ApplicationArea = All;
                Caption = 'Correct Email';
                ToolTip = 'Check is email corrected';
            }
        }
    }
    var
        CorrectEmail: boolean;

    local procedure RegexMatch(Input: Text;
        Pattern: Text): Boolean
    var
        Regex: DotNet RegExp;
    begin
        Regex := Regex.Regex(Pattern);
        EXIT(Regex.IsMatch(Input));
    end;

    trigger OnAfterGetRecord()
    var
        Pattern: Text;
    begin
        Pattern := '^([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$';
        if "E-Mail" <> '' then
            CorrectEmail := RegexMatch("E-Mail", Pattern)
        else
            CorrectEmail := true;
    end;

}

