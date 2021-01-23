import { ELBv2 } from 'aws-sdk'
import { TargetGroup } from '@/domain/model/aws/targetGroup/TargetGroup'
import { TargetGroupApiInterface } from '@/domain/model/aws/targetGroup/TargetGroupApiInterface'
import { CreateTargetGroupInput } from 'aws-sdk/clients/elbv2'
import { createLambdaLogger } from '@/util/logger'

/**
 * target groupの追加と削除を行う
 */
export class TargetGroupApi implements TargetGroupApiInterface {
  private elbV2Api = new ELBv2()
  private logger = createLambdaLogger()
  /**
   * ターゲットグループの追加を行う
   * @param targetGroup 追加するTargetGroup
   */
  async addTargetGroup(targetGroup: TargetGroup): Promise<string> {
    try {
      const params: CreateTargetGroupInput = targetGroup.awsApiRequestParams
      this.loggerTargetGroupParams(params)
      const res = await this.elbV2Api.createTargetGroup(params).promise()
      // 失敗系
      if (!res.TargetGroups || res.TargetGroups.length < 1) {
        const message = 'failed add target group. response is invalid'
        this.logger.log({
          level: 'warn',
          message: message,
          class: 'TargetGroupApi',
          method: 'addTargetGroup',
        })
        throw new Error(message)
      }
      const arn = res.TargetGroups[0].TargetGroupArn ?? ''

      this.logger.log({
        level: 'info',
        message: `aws sdk request is success. arn: ${arn}`,
        class: 'TargetGroupApi',
        method: 'addTargetGroup',
      })
      return arn
    } catch (e) {
      const message = (e as Error).message
      this.logger.log({
        level: 'error',
        message: message,
        class: 'TargetGroupApi',
        method: 'addTargetGroup',
      })
      throw Error(e)
    }
  }

  private loggerTargetGroupParams(params: CreateTargetGroupInput) {
    const jsonStrParams = JSON.stringify(params)
    this.logger.log({
      level: 'info',
      message: `input target group params: ${jsonStrParams}`,
      rawParams: params,
      class: 'TargetGroupApi',
    })
  }
}
