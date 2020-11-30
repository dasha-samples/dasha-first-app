library

digression sorry_wont_call
{
    conditions 
    {
        on #messageHasAnyIntent(digression.sorry_wont_call.triggers) priority 1010;
    }
    var triggers = ["do_not_call", "you_already_called_me", "wrong_number", "whom_do_you_call", "obscene"];
    var responses: Phrases[] = ["sorry_wont_call"];
    var status = "DontCall";
    var serviceStatus="Done";
    do
    {
        for (var item in digression.sorry_wont_call.responses)
        {
            #say(item);
        }
        set $status=digression.sorry_wont_call.status;
        set $serviceStatus=digression.sorry_wont_call.serviceStatus;
        set $callBackDetails = #message.originalText;
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
