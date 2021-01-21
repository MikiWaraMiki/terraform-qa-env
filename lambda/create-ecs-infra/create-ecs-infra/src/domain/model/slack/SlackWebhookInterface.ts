import { SlackMessage } from '@/domain/model/slack/SlackMessage'

/**
 * インフラ層のinterface
 */
export type SlackWebhookInterface = {
  readonly incomingWebhookURL: string

  send(slackMessage: SlackMessage): Promise<number>
}
