import { EC2 } from 'aws-sdk'
import { IngressSecurityGroupRule } from '@/domain/model/aws/securityGroup/IngressSecurityGroupRule'
import { SecurityGroupApiInterface } from '@/domain/model/aws/securityGroup/SecurityGroupApiInterface'
import { createLambdaLogger } from '@/util/logger'
import { AuthorizeSecurityGroupIngressRequest } from 'aws-sdk/clients/ec2'
import { AuthorizeDBSecurityGroupIngressResult } from 'aws-sdk/clients/rds'

export class SecurityGroupApi implements SecurityGroupApiInterface {
  private readonly ec2 = new EC2()
  private readonly logger = createLambdaLogger()

  /**
   * Inboundのセキュリティグループを追加する
   * @param rule 追加するセキュリティグループ
   */
  async addIngressRule(rule: IngressSecurityGroupRule): Promise<boolean> {
    try {
      this.loggingSecurityGroup(rule)
      await this.ec2.authorizeSecurityGroupIngress(rule).promise()
      return true
    } catch (e) {
      e as Error
      this.logger.log({
        level: 'error',
        message: `[SecurityGroupApi][addIngressApi] cannot added rule. ${e.message}`,
      })
      return false
    }
  }

  /**
   * 追加するセキュリティグループのログ出力
   */
  private loggingSecurityGroup(rule: IngressSecurityGroupRule) {
    const prefix = '[SecurityGroupApi][addIngressApi]'
    this.logger.log({
      level: 'info',
      message: `${prefix} add security group`,
    })
    const jsonStrRule = JSON.stringify(rule)
    this.logger.log({
      level: 'info',
      message: `${prefix} ${jsonStrRule}`,
    })
  }
}
