library

preprocessor digression repeat_preprocessor
{
    conditions { on true priority 50000; }
    do
    {
        if (digression.repeat.resetOnRecognized)
        {
            set digression.repeat.counter = 0;
        }
        set digression.repeat.resetOnRecognized = true;
        return;
    }
    transitions
    {
    }
}

digression repeat_hangup_params
{
    conditions { on false; }
    var responses: Phrases[] = ["dont_understand_hangup"];
    var status = "RepeatHangup";
    var serviceStatus = "Done";
    do
    {
    }
    transitions
    {
    }
}

digression repeat
{
    conditions { on #messageHasAnyIntent(digression.repeat.triggers); }
    var retriesLimit = 2;
    var counter = 0;
    var resetOnRecognized=false;
    var triggers = ["repeat", "dont_understand"];
    var responses: Phrases[] = ["i_said"];
    do
    {
        if (digression.repeat.counter > digression.repeat.retriesLimit)
        {
            goto hangup;
        }
        set digression.repeat.counter = digression.repeat.counter + 1;
        set digression.repeat.resetOnRecognized = false;
        for (var item in digression.repeat.responses)
        {
            #say(item, repeatMode: "ignore");
        }
        #repeat();
        return;
    }
    transitions
    {
        hangup: goto repeat_or_ping_hangup;
    }
}

digression ping
{
    conditions { on false; }
    do
    {
        if (digression.repeat.counter > digression.repeat.retriesLimit)
        {
            goto hangup;
        }
        
        #repeat(accuracy: "short");
        set digression.repeat.counter = digression.repeat.counter + 1;
        return;
    }
    transitions
    {
        hangup: goto repeat_or_ping_hangup;
    }
}

node repeat_or_ping_hangup
{
    do
    {
        for (var item in digression.repeat_hangup_params.responses)
        {
            #say(item, repeatMode: "ignore");
        }
        set $status=digression.repeat_hangup_params.status;
        set $serviceStatus=digression.repeat_hangup_params.serviceStatus;
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
