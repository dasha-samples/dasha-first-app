library

/**
* Reaction if nothing meaningful happens in the dialogue for too long.
*/
preprocessor digression hello
{
    conditions { on #getIdleTime() - digression.hello.lastIdleTime > digression.hello.idleTimeLimit tags: ontick; }
    var idleTimeLimit=8000;
    var lastIdleTime=0;
    var retriesLimit=2;
    var counter=0;
    do
    {
        set digression.hello.lastIdleTime=#getIdleTime();
        if (digression.hello.counter > digression.hello.retriesLimit)
        {
            goto hangup;
        }
        set digression.hello.counter=digression.hello.counter+1;
        #say("hello", repeatMode: "ignore");
        return;
    }
    transitions
    {
        hangup: goto hello_hangup;
    }
}

preprocessor digression hello_preprocessor
{
    conditions { on true priority 50000; }
    do
    {
        set digression.hello.lastIdleTime = 0;
        set digression.hello.counter = 0;
        return;
    }
    transitions
    {
    }
}

node hello_hangup
{
    do
    {
        set $status="EmptyCall";
        set $serviceStatus="Done";
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
