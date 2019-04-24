codeunit 50102 "Check Sales Mgt"
{


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure BeforePostSalesDoc()
    begin
        Message('OnBeforePostLines');
    end;

    local procedure MyProcedure()
    var
        GLPost: Codeunit "Gen. Jnl.-Post";
    begin

    end;

}