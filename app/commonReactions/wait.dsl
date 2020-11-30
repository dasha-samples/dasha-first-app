library

digression @wait
{
    conditions { on #messageHasAnyIntent(digression.@wait.triggers)  priority 900; }
    var triggers = ["wait", "wait_for_another_person"];
    var responses: Phrases[] = ["i_will_wait"];
    do
    {
        for (var item in digression.@wait.responses)
        {
            #say(item, repeatMode: "ignore");
        }
        #waitingMode(duration: 60000);
        return;
    }
    transitions
    {
    }
}
