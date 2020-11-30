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
        #say("greeting");
        wait *;
    }
    transitions
    {
        transition0: goto track_parcel on #messageHasIntent("track_parcel");
        transition1: goto missed_delivery on #messageHasIntent("missed_delivery");
        transition2: goto where_is_point on #messageHasIntent("where_is_point");
        transition3: goto return_shipment on #messageHasIntent("return_shipment");
    }
}
node track_parcel
{
    do
    {
        #say("track_parcel");
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
        #say("missed_delivery");
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
        #say("where_is_point");
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
        #say("return_shipment");
        #disconnect();
        exit;
    }
    transitions
    {
    }
}
