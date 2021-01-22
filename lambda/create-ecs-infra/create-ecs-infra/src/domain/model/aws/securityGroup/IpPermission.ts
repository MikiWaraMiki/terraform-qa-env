import { SourceIpRule } from '@/domain/model/aws/securityGroup/SourceIpRule'
import { SourceSecurityGroupRule } from '@/domain/model/aws/securityGroup/SourceSecurityGroupRule'

/**
 * セキュリティグループルール定義を示すクラス
 */
export class IpPermission {
  // 許可/拒否するポート
  private readonly fromPort: number
  private readonly toPort: number
  // protocol
  private readonly ipProtocol: AwsSecurityGroupProtocol
  // 制限するIPアドレスルールのリスト
  private sourceIpRuleList: SourceIpRule[] = []
  // 制限するセキュリティグループのリスト
  private sourceSecurityGroupList: SourceSecurityGroupRule[] = []

  constructor(
    fromPort: number,
    toPort: number,
    ipProtocol: AwsSecurityGroupProtocol,
  ) {
    this.fromPort = fromPort
    this.toPort = toPort
    this.ipProtocol = ipProtocol
  }

  // IPベースのルールを追加する
  addIpRule(cidrIp: string, description: string) {
    const ipRule = new SourceIpRule(cidrIp, description)
    this.sourceIpRuleList.push(ipRule)
  }

  // セキュリティグループベースのルールを追加する
  addSecurityGroupRule(groupId: string, description: string) {
    const sgRule = new SourceSecurityGroupRule(groupId, description)
    this.sourceSecurityGroupList.push(sgRule)
  }

  // AWS APIベースのリクエストパラメータを返す
  // TODO: おそらくドメイン層の役割ではないので、インフラ層に移行する
  get awsApiRequestParams(): AwsRequestIpPermissions {
    const baseRequestParams = {
      FromPort: this.fromPort,
      ToPort: this.toPort,
      IpProtocol: this.ipProtocol,
    }
    // MEMO sdkの都合上、空配列だとエラーになるので、変換する
    const ipRangeParams =
      this.sourceIpRuleList.length > 0
        ? {
            IpRanges: this.sourceSecurityGroupList.map(
              (rule) => rule.awsApiRequestParams,
            ),
          }
        : {}
    const userIdGroupPairsParams =
      this.sourceSecurityGroupList.length > 0
        ? {
            UserIdGroupPairs: this.sourceIpRuleList.map(
              (rule) => rule.awsApiRequestParams,
            ),
          }
        : {}

    return {
      ...baseRequestParams,
      ...ipRangeParams,
      ...userIdGroupPairsParams,
    }
  }
}
