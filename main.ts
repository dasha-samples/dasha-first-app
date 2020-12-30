import DashaSdk, * as dasha from "@dasha.ai/platform-sdk";

import { createJob } from "./createJob";
import { createLogger, recordToUrl, runConsoleChat } from "./helpers";

async function main() {
  const sdk = new DashaSdk({
    url: "app.us.dasha.ai",
    apiKey: process.env.DASHA_APIKEY!
  });
  let app: dasha.IApplication;
  try {
    app = await sdk.registerApp({
      appPackagePath: "./app",
      concurrency: 1,
      progressReporter: dasha.progress.consoleReporter,
    });
    app.setLogger(console);
    console.log(`App ${app.applicationId}, instance ${app.instanceId}`);

    await app.addSessionConfig({ name: "text", config: { type: "text" } });
    await app.addSessionConfig({
      name: "audio",
      config: {
        type: "audio",
        channel: {
          type: "sip",
          configName: "default"
        },
        stt: {
          configName: "Default-en"
        },
        tts: {
          type: "synthesized",
          configName: "Dasha"
        }
      }
    });
    await app.addSessionConfig({
      name: "inbound",
      config: {
        type: "audio",
        channel: {
          type: "sip",
          inbound: {
            account: "external",
            password: "",
            ipAcl: [],
            priority: 7
          }
        },
        stt: {
          configName: "Default-en",
        },
        tts: {
          type: "synthesized",
          configName: "Dasha"
        }
      }
    });

    const phone = process.argv[2];
    app.onJob({
      startingJob: async (serverId, id, incomingData) => {
        console.log(`Staring job ${id}`, { serverId, ...incomingData });
        const job = createJob(id === "testJob" && phone !== "chat" ? phone : "");
        
        if (id === "testJob" && phone === "chat") {
          const debugEvents = createLogger({ logFile: "log.txt" });
          runConsoleChat(await sdk.connectChat(serverId)).catch(console.error);
          return { accept: true, ...job, debugEvents, sessionConfigName: "text" };
        } else {
          const debugEvents = createLogger({ log: console.log, logFile: "log.txt" });
          return { accept: true, ...job, debugEvents, sessionConfigName: "audio" };
        }
      },
      completedJob: async (id, result, records) => {
        records.map(recordToUrl).forEach(url => console.log({ recordUrl: url }));
        console.log(`Completed job ${id}`, result);
      },
      failedJob: async (id, error, records) => {
        records.map(recordToUrl).forEach(url => console.log({ recordUrl: url }));
        console.log(`Failed job ${id}`, error);
      },
      timedOutJob: async (id) => {
        console.log(`Job ${id} timed out`);
      }
    });

    if (phone) {
      await app.enqueueJobs([
        { id: "testJob", notAfter: new Date(Date.now() + 3600 * 1000) }
      ]);
      console.log(`Enqueued job: connect to ${phone}`);
    }

  } catch (e) {
    console.error(e);
  }
}

main();
