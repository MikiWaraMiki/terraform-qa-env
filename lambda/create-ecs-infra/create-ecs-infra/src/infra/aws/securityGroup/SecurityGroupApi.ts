import { IngressSecurityGroupRule } from '@/domain/model/aws/securityGroup/IngressSecurityGroupRule'
import { SecurityGroupApiInterface } from '@/domain/model/aws/securityGroup/SecurityGroupApiInterface'
import { createLambdaLogger } from '@/util/logger'
import { SecurityGroupCoreApi } from '@/infra/aws/securityGroup/SecurityGroupCoreApi'

export class SecurityGroupApi implements SecurityGroupApiInterface {
  private readonly sgApi = new SecurityGroupCoreApi()
  private readonly logger = createLambdaLogger()

  /**
   * Inboundのセキュリティグループを追加する
   * @param rule 追加するセキュリティグループ
   */
  async addIngressRule(rule: IngressSecurityGroupRule): Promise<boolean> {
    try {
      await this.sgApi.addIngressRule(rule)
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
    const jsonStrRule = JSON.stringify(rule.awsApiRequestParams)
    this.logger.log({
      level: 'info',
      message: `${prefix} ${jsonStrRule}`,
    })
  }
}
