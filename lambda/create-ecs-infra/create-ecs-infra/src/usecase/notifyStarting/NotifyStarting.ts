import {
  SlackMessage,
  SlackMessageType,
} from '@/domain/model/slack/SlackMessage'
import { SlackWebhookInterface } from '@/domain/model/slack/SlackWebhookInterface'
import { createLambdaLogger } from '@/util/logger'

const slackMessageType = (attachments: Attachment[]): SlackMessageType => {
  return {
    text: 'QA環境のデプロイがスタートしました。完了までお待ちください',
    attachments,
  }
}

const createAttachmentAboutBranch = (branch: string): Attachment => {
  return {
    fallback: `${branch}のQA環境を作成開始しました`,
    color: 'good',
  }
}

/**
 *
 * @param webhook slackWebhookInterface
 * @param branchName QA環境のブランチ名
 */
const notifyStarting = async (
  webhook: SlackWebhookInterface,
  branchName: string,
): Promise<number> => {
  const logger = createLambdaLogger()

  const attachments = createAttachmentAboutBranch(branchName)
  const slackMessage = new SlackMessage(slackMessageType([attachments]))

  const res = await webhook.send(slackMessage)
  logger.log({
    level: 'debug',
    message: 'sended slack notification of starting',
  })
  return res
}

export { notifyStarting }
