library

context
{
    output serviceStatus: string?;
}

digression hangup
{
    conditions
    {
        on true priority 50000 tags: onclosed;
    }

    var serviceStatus = "UserHangup";

    do
    {
        set $serviceStatus = digression.hangup.serviceStatus;
        exit;
    }
}
