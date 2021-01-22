import { IpPermission } from '@/domain/model/aws/securityGroup/IpPermission'

/**
 * Security Group Rule Inboundの定義
 * See https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/EC2.html#authorizeSecurityGroupIngress-property
 */
export class IngressSecurityGroupRule {
  private readonly groupId: string
  private ipPermissions: IpPermission[]
  private dryRun: boolean = false

  constructor(groupId: string, ipPermissions: IpPermission[]) {
    this.groupId = groupId
    this.ipPermissions = ipPermissions
  }

  get awsApiRequestParams(): AwsIngressSecurityGroupRule {
    return {
      GroupId: this.groupId,
      DryRun: this.dryRun,
      IpPermissions: this.ipPermissions.map(
        (permission) => permission.awsApiRequestParams,
      ),
    }
  }
  /**
   * IP Permissionsの追加
   */
  addIpPermissions(ipPermission: IpPermission) {
    this.ipPermissions.push(ipPermission)
  }
  /**
   * テスト実行モードをセットする
   */
  setDryRun() {
    this.dryRun = true
  }
}
