/**
 * 送信元APIをベースに定義するルールクラス
 */
export class SourceSecurityGroupRule {
  private readonly groupId: string
  private readonly description: string

  constructor(groupId: string, description: string) {
    this.groupId = groupId
    this.description = description
  }

  get awsApiRequestParams(): AwsRequestSourceSecurityGroupRule {
    return {
      GroupId: this.groupId,
      Description: this.description,
    }
  }
}
