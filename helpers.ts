import { AudioRecord, IChatChannel } from "@dasha.ai/platform-sdk";
import * as fs from "fs";
import * as readline from "readline";

export function createLogger(options?: {
  log?: typeof console.log;
  logFile?: string;
}) {
  const appendLog = async (str: string) => {
    if (options?.logFile) {
      await fs.promises.appendFile(options.logFile, str);
    }
  }
  appendLog(`${"#".repeat(100)}\n`);
  return {
    log: async (msg: string) => {
      options?.log?.({ Log: msg });
      await appendLog(`Log: ${msg}\n`);
    },
    transcription: async (msg: string, incoming: boolean) => {
      options?.log?.(incoming ? { Human: msg } : { AI: msg });
      await appendLog(incoming ? `Human: ${msg}\n` : `AI: ${msg}\n`);
    },
    raw: async (devlog: any) => {
      if (devlog.msg.msgId === "RecognizedSpeechMessage") {
        await appendLog(JSON.stringify(devlog.msg.results[0]?.facts, undefined, 2) + "\n");
      }
    }
  }
}

export function recordToUrl(record: AudioRecord) {
  return `https://dasha-call-records-public-beta.s3.amazonaws.com/${record.recordId}/call.mp3`;
}

export async function runConsoleChat(chatChannel: IChatChannel) {
  const cli = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  console.log("Chat opened");
  let closed = false;
  chatChannel.receivedMessages.subscribe({
    next: (text) => {
      console.log("AI:", text);
    },
    complete: () => {
      closed = true;
      console.log("Chat closed");
    },
    error: (error) => {
      closed = true;
      console.warn("Chat error:", error);
    },
  });

  for await (const line of cli) {
    if (closed || line === "") {
      await chatChannel.close();
      break;
    } else {
      await chatChannel.sendMessage(line);
    }
  }

  cli.close();
}
