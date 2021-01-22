/**
 * 送信元IPをベースに定義するルールクラス
 */
export class SourceIpRule {
  readonly cidrIp: string
  readonly description: string

  constructor(cidrIp: string, description: string) {
    this.cidrIp = cidrIp
    this.description = description
  }

  /**
   * aws-sdkのセキュリティグループ系のルールがパスカルケースなので、ここで対応
   * [TODO]: 責務的にドメインモデルではないので、インフラ層に移行する
   */
  get awsApiRequestParams(): AwsRequestSourceIpRule {
    return {
      CidrIp: this.cidrIp,
      Description: this.description,
    }
  }
}
