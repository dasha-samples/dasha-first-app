library

digression answering_machine
{
    conditions { on #messageHasAnyIntent(digression.answering_machine.triggers); }
    var triggers = ["answering_machine"];
    var serviceStatus = "AnsweringMachine";
    var status = "AnsweringMachine";
    do
    {
        set $serviceStatus=digression.answering_machine.serviceStatus;
        set $status=digression.answering_machine.status;
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
