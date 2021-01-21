import { SlackMessage } from '@/domain/model/slack/SlackMessage'
import { SlackWebhookInterface } from '@/domain/model/slack/SlackWebhookInterface'
import { createLambdaLogger } from '@/util/logger'
import axios from 'axios'
export class SlackWebhook implements SlackWebhookInterface {
  readonly incomingWebhookURL: string
  readonly logger = createLambdaLogger()
  constructor(incomingWebhookURL: string) {
    if (!incomingWebhookURL) {
      throw new Error('Slack Webhook URLが空文字です')
    }
    this.incomingWebhookURL = incomingWebhookURL
  }
  /**
   *
   * @param slackMessage 送信するSlackのメッセージ
   */
  async send(slackMessage: SlackMessage): Promise<number> {
    this.logger.log({
      level: 'debug',
      message: `sending slack message. url: ${this.incomingWebhookURL}, params: ${slackMessage}`,
    })
    const res = await axios.post(this.incomingWebhookURL, slackMessage)
    this.logger.log({
      level: 'debug',
      message: `sended slack message. response: ${res}`,
    })
    return res.status
  }
}
