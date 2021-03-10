import "commonReactions/all.dsl";

context {
    input phone: string;
}

start node root
{
    do
    {
        #connectSafe($phone);
        #waitForSpeech(1000);
        #sayText("Welcome to Acme Postal Service. How can I help you?");
        wait *;
    }
    transitions
    {
        track_parcel: goto track_parcel on #messageHasIntent("track_parcel");
        missed_delivery: goto missed_delivery on #messageHasIntent("missed_delivery");
        where_is_point: goto where_is_point on #messageHasIntent("where_is_point");
        return_shipment: goto return_shipment on #messageHasIntent("return_shipment");
    }
}
node track_parcel
{
    do
    {
        #sayText("Sorry, tracking function is not implemented yet.");
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
node missed_delivery
{
    do
    {
        #sayText("Sorry, rescheduling function is not implemented yet.");
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
node where_is_point
{
    do
    {
        #sayText("Sorry, closest location function is not implemented yet.");
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
node return_shipment
{
    do
    {
        #sayText("Sorry, shipment return function is not implemented yet.");
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
