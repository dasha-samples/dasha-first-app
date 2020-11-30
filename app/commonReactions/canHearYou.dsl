library

digression can_hear_you
{
        conditions { on #messageHasAnyIntent(digression.can_hear_you.triggers) priority -100; }
        var triggers = ["can_you_hear_me"];
        var responses: Phrases[] = ["i_can_hear_you"];
        do
        {
                for (var item in digression.can_hear_you.responses)
                {
                        #say(item, repeatMode: "ignore");
                }
                return;
        }
        transitions
        {
        }
}
