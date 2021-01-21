/**
 * Slackのメッセージカラーを表現する
 * GOOD, WARNING, DANGERのみ
 */
declare const SlackColorEnum = {
  GOOD: 'good',
  WARNING: 'warning',
  DANGER: 'danger',
} as const

declare type SlackColor = typeof SlackColorEnum[keyof typeof SlackColorEnum]
/**
 * Slackメッセージ部分
 */
declare type Field = {
  title: string
  value: string
  short?: boolean
}
/**
 * Slack Attachment
 */
declare type Attachment = {
  fallback?: string
  color?: SlackColor
  pretext?: string
  authorName?: string
  authorLink?: string
  authorIcon?: string
  title?: string
  titleLink?: string
  text?: string
  fields?: Field[]
  imageUrl?: string
  thumbUrl?: string
  timeStamp?: number
}
