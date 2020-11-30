# How to start the demo app

This example shows how to build conversational IVR on top of Dasha. If you need any help, join us in our [Slack Community](https://join.slack.com/t/dashacommunity/shared_invite/zt-jhibmznm-kiQ336q5IqYtK6EnYyV_Nw).

1. Set environment variable `DASHA_APIKEY` (or create a file `.env` that contains `DASHA_APIKEY=<your_apikey>`). To receive your Dasha API key, enroll into our beta program here https://dasha.ai/en-us/developers.
2. Run `npm i`.
3. Run one of the following:
    * To start outbound call run `npm start <phone_number>` (phone number in international format without `+`, for instance `12223334455`).
    * To start text chat run `npm start chat`.
    * To start accepting inbound calls run `npm start` (but other starting options accept incoming calls as well). Then use this test inbound phone number to call `+358753267899` (for test purposes only! could be changed anytime).