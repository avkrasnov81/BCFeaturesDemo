page 50100 "Holidays"
{
    PageType = List;
    SourceTable = Holiday;

    Editable = false;
    SourceTableView = order(descending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("date"; "date")
                {
                    ApplicationArea = All;
                }
                field("localName"; "localName")
                {
                    ApplicationArea = All;
                }
                field("name"; "name")
                {
                    ApplicationArea = All;
                }
                field("countryCode"; "countryCode")
                {
                    ApplicationArea = All;
                }
                field("fixed"; "fixed")
                {
                    ApplicationArea = All;
                }
                field("global"; "global")
                {
                    ApplicationArea = All;
                }
                field("type"; "type")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Refresh)
            {
                Caption = 'Refresh ';
                Promoted = true;
                PromotedCategory = Process;
                Image = RefreshLines;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    Refresh();
                    CurrPage.Update;
                    if FindFirst then;
                end;
            }
        }
    }
}


