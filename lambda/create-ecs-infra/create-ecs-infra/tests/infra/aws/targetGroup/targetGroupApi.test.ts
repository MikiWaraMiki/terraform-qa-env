import { HealthCheckSetting } from '@/domain/model/aws/targetGroup/HealthCheckSetting'
import { TargetGroup } from '@/domain/model/aws/targetGroup/TargetGroup'
import { TargetGroupApi } from '@/infra/aws/targetGruop/TargetGroupApi'
import * as AWS from 'aws-sdk'
import * as dotenv from 'dotenv'
import * as path from 'path'

// dotenvからAWSの認証情報をロード
const config = dotenv.config({
  path: path.join(__dirname, '../../../../dotenv/.env'),
}).parsed
if (config === undefined) throw 'not set aws profile name'

AWS.config.region = config.AWS_REGION
AWS.config.credentials = {
  accessKeyId: config.AWS_ACCESS_KEY_ID,
  secretAccessKey: config.AWS_SECRET_ACCESS_KEY,
}
const VPC_ID = config.TEST_VPC_ID ?? ''

const targetGroupApi = new TargetGroupApi()
describe('TargetGroupApiのテスト', (): void => {
  test('target groupの追加ができること', async (): Promise<void> => {
    const healthCheckSetting = new HealthCheckSetting('/', 'HTTP', '80')
    const targetGroup = new TargetGroup(
      VPC_ID,
      'test-target-group',
      80,
      'HTTP',
      healthCheckSetting,
    )
    targetGroup.addTags({ Key: 'test', Value: 'test' })

    const arn = await targetGroupApi.addTargetGroup(targetGroup)
    expect(arn).not.toBeUndefined()
  })

  test('追加に失敗した場合は例外が発生すること', async (): Promise<void> => {
    const healthCheckSetting = new HealthCheckSetting('/', 'HTTP', '80')
    const targetGroup = new TargetGroup(
      '',
      'test-target-group',
      80,
      'HTTP',
      healthCheckSetting,
    )

    await expect(targetGroupApi.addTargetGroup(targetGroup)).rejects.toThrow()
  })
})
