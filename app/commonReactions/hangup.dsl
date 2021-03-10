library
context
{
    output serviceStatus: string?;
}

digression hangup
{
    conditions
    {
        on true tags: onclosed;
    }
    var serviceStatus = "UserHangup";
    do
    {
        set $serviceStatus = digression.hangup.serviceStatus;
        //#disconnect();
        exit;
    }
    transitions
    {
    }
}
