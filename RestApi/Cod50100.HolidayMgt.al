codeunit 50100 "Holiday Mgt"
{
    procedure Refresh();
    var
        Holiday: Record Holiday;
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JsonToken: JsonToken;
        JsonValue: JsonValue;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonText: text;
        i: Integer;
    begin
        Holiday.DeleteAll;

        // Simple web service call
        HttpClient.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
        if not HttpClient.Get('https://date.nager.at/api/v2/PublicHolidays/2019/ru',
                              ResponseMessage)
        then
            Error('The call to the web service failed.');

        if not ResponseMessage.IsSuccessStatusCode then
            error('The web service returned an error message:\' +
                  'Status code: %1' +
                  'Description: %2',
                  ResponseMessage.HttpStatusCode,
                  ResponseMessage.ReasonPhrase);

        ResponseMessage.Content.ReadAs(JsonText);

        // Process JSON response
        if not JsonArray.ReadFrom(JsonText) then begin
            // probably single object
            JsonToken.ReadFrom(JsonText);
            Insert(JsonToken);
        end else begin
            // array
            for i := 0 to JsonArray.Count - 1 do begin
                JsonArray.Get(i, JsonToken);
                Insert(JsonToken);
            end;
        end;
    end;

    procedure Insert(JsonToken: JsonToken);
    var
        JsonObject: JsonObject;
        Holiday: Record Holiday;
    begin
        JsonObject := JsonToken.AsObject;

        Holiday.init;

        Holiday."date" := COPYSTR(GetJsonToken(JsonObject, 'date').AsValue.AsText, 1, 250);
        Holiday."localName" := COPYSTR(GetJsonToken(JsonObject, 'localName').AsValue.AsText, 1, 250);
        Holiday."name" := COPYSTR(GetJsonToken(JsonObject, 'name').AsValue.AsText, 1, 250);
        Holiday."countryCode" := COPYSTR(GetJsonToken(JsonObject, 'countryCode').AsValue.AsText, 1, 250);
        Holiday."fixed" := GetJsonToken(JsonObject, 'fixed').AsValue.AsBoolean;
        Holiday."global" := GetJsonToken(JsonObject, 'global').AsValue.AsBoolean;
        Holiday."type" := COPYSTR(GetJsonToken(JsonObject, 'type').AsValue.AsText, 1, 250);

        Holiday.Insert;
    end;

    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

}
