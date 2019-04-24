table 50100 "Holiday"
{

    fields
    {

        field(1; "date"; Text[250])
        {
            Caption = 'date';
        }
        field(2; "localName"; Text[250])
        {
            Caption = 'localName';
        }
        field(3; "name"; Text[250])
        {
            Caption = 'name';
        }
        field(4; "countryCode"; Text[250])
        {
            Caption = 'countryCode';
        }
        field(5; "fixed"; Boolean)
        {
            Caption = 'fixed';
        }
        field(6; "global"; Boolean)
        {
            Caption = 'global';
        }
        field(7; "type"; Text[250])
        {
            Caption = 'type';
        }

    }

    procedure Refresh();
    var
        Refresh: Codeunit "Holiday Mgt";
    begin
        Refresh.Refresh();
    end;

}
