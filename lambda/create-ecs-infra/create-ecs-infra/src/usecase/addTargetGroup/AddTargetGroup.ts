import { HealthCheckSetting } from '@/domain/model/aws/targetGroup/HealthCheckSetting'
import { TargetGroup } from '@/domain/model/aws/targetGroup/TargetGroup'
import { TargetGroupApiInterface } from '@/domain/model/aws/targetGroup/TargetGroupApiInterface'
import { createLambdaLogger } from '@/util/logger'

const addTargetGroup = async (
  branchName: string,
  vpcId: string,
  targetGroupApi: TargetGroupApiInterface,
): Promise<string> => {
  const logger = createLambdaLogger()
  try {
    if (!branchName || !vpcId) {
      const mes = `branch or vpcId is empty string. branchName: ${branchName}, vpcId: ${vpcId}`
      logger.log({
        level: 'warn',
        message: mes,
        class: 'AddTargetGroup',
        method: 'addTargetGroup',
      })
      throw new Error(mes)
    }
    logger.log({
      level: 'info',
      message: `add target group. branchName: ${branchName}, vpcId: ${vpcId}`,
      class: 'AddTargetGroup',
      method: 'addTargetGroup',
    })

    const tgName = `${branchName}-${process.env.PJPrefix}`
    const healthCheckSetting = new HealthCheckSetting('/', 'HTTP', '80')
    const targetGroup = new TargetGroup(
      vpcId,
      tgName,
      80,
      'HTTP',
      healthCheckSetting,
    )

    const arn = await targetGroupApi.addTargetGroup(targetGroup)

    logger.log({
      level: 'info',
      message: 'success add target group',
      class: 'AddTargetGroup',
      method: 'addTargetGroup',
    })

    return arn
  } catch (e) {
    const mes = (e as Error).message
    logger.log({
      level: 'error',
      message: 'failed add target group',
      exceptionMessage: mes,
      exception: (e as Error).stack,
    })
    throw e
  }
}

export { addTargetGroup }
