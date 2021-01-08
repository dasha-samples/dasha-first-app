# How to start the demo app

This example shows how to build conversational IVR on top of Dasha. If you need any help, join us in our [Developer Community](https://discord.gg/R8mDP2JGmv).

1. Set environment variable `DASHA_APIKEY` (or create a file `.env` that contains `DASHA_APIKEY=<your_apikey>`). To receive your Dasha API key, enroll into our beta program here https://dasha.ai/en-us/developers.
2. Run `npm i`.
```sh
npm i
```
3. Run one of the following:
    * To start outbound call run
    ```sh
    npm start <phone_number>
    ```
     (phone number in international format without `+`, for instance `12223334455`).
    * To start text chat run
    ```sh
    npm start chat
    ```
