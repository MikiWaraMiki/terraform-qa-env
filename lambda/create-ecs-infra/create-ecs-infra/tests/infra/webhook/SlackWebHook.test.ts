import {
  SlackMessage,
  SlackMessageType,
} from '@/domain/model/slack/SlackMessage'
import { SlackWebhook } from '@/infra/slack/SlackWebhook'
import * as dotenv from 'dotenv'
import * as path from 'path'

// Test用のSlackWebhookURLを読み込み
const config = dotenv.config({
  path: path.join(__dirname, '../../../dotenv/.env'),
}).parsed
if (config === undefined) throw 'Cannot Load Dotenv'

const slackWebhookURL = config.SLACK_WEBHOOK_URL ?? ''
const slackWebhook = new SlackWebhook(slackWebhookURL)

const slackMessageOpts: SlackMessageType = {
  text: 'test',
  username: 'test',
  attachments: [],
}
const slackMessage = new SlackMessage(slackMessageOpts)
describe('SlackWebHook Test', (): void => {
  test('test', async (): Promise<void> => {
    try {
      const res = await slackWebhook.send(slackMessage)
      expect(res).toBe(200)
    } catch (e) {
      console.error('unexpected error')
      console.error(e)
    }
  })
})
