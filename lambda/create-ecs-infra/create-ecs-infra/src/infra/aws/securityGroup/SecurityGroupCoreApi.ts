import { IngressSecurityGroupRule } from '@/domain/model/aws/securityGroup/IngressSecurityGroupRule'
import { EC2 } from 'aws-sdk'
import { AuthorizeSecurityGroupIngressRequest } from 'aws-sdk/clients/ec2'

export class SecurityGroupCoreApi {
  private readonly ec2Api = new EC2()

  /**
   * セキュリティグループのイングレスルールを１件追加する
   */
  async addIngressRule(rule: IngressSecurityGroupRule): Promise<void> {
    const params: AuthorizeSecurityGroupIngressRequest =
      rule.awsApiRequestParams
    await this.ec2Api.authorizeSecurityGroupIngress(params).promise()
  }
}
