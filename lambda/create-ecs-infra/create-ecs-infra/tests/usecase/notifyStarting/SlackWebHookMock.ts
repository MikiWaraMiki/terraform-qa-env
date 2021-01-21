import { SlackMessage } from '@/domain/model/slack/SlackMessage'
import { SlackWebhookInterface } from '@/domain/model/slack/SlackWebhookInterface'

export class SlackWebHookMock implements SlackWebhookInterface {
  incomingWebhookURL: string
  constructor() {
    this.incomingWebhookURL = ''
  }
  async send(slackMessage: SlackMessage): Promise<number> {
    const res = await 200
    return res
  }
}
