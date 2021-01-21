export type SlackMessageType = {
  text: string
  channel?: string
  username?: string
  icon_emoji?: string
  icon_url?: string
  link_names?: 0 | 1
  attachments: Attachment[]
}
export class SlackMessage implements SlackMessageType {
  text: string
  channel?: string | undefined
  username?: string | undefined
  icon_emoji?: string | undefined
  icon_url?: string | undefined
  link_names?: 0 | 1 | undefined
  attachments: Attachment[]

  constructor(slackMessageType: SlackMessageType) {
    this.text = slackMessageType.text
    this.channel = slackMessageType.channel
    this.username = slackMessageType.username
    this.icon_emoji = slackMessageType.icon_emoji
    this.icon_url = slackMessageType.icon_url
    this.link_names = slackMessageType.link_names
    this.attachments = slackMessageType.attachments
  }

  /**
   * Attachmentを追加する
   * @param attachment 追加するAttachment
   */
  addAttachment(attachment: Attachment) {
    this.attachments.push(attachment)
  }
}
