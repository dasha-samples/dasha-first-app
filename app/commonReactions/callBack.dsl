library
context
{
    output status:string?;
    output serviceStatus:string?;
    output callBackDetails:string?;
}

digression i_will_call_back
{
    conditions { on #messageHasAnyIntent(digression.i_will_call_back.triggers) priority 1010; }
    var triggers = ["call_later"];
    var responses: Phrases[] = ["i_will_call_back"];
    var serviceStatus = "Done";
    var status = "CallBack";
    do
    {
        for (var item in digression.i_will_call_back.responses)
        {
            #say(item);
        }
        set $serviceStatus=digression.i_will_call_back.serviceStatus;
        set $status=digression.i_will_call_back.status;
        set $callBackDetails = #message.originalText;
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
