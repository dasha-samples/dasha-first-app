library

digression swear_words
{
    conditions 
    {
        on #messageHasAnyIntent(digression.swear_words.triggers) priority 1010;
    }
    var triggers = ["swear_words"];
    var responses: Phrases[] = ["dont_understand_forward"];
    var status = "AngryCustomer";
    var serviceStatus="Done";
    do
    {
        for (var item in digression.swear_words.responses)
        {
            #say(item);
        }
        set $status=digression.swear_words.status;
        set $serviceStatus=digression.swear_words.serviceStatus;
        set $callBackDetails = #message.originalText;

        //#forward("12223334455");    //use if you want to transfer a call
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
