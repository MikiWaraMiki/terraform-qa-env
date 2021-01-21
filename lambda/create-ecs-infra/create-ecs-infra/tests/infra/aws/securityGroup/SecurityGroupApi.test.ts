import { IngressSecurityGroupRule } from '@/domain/model/aws/securityGroup/IngressSecurityGroupRule'
import { SecurityGroupApi } from '@/infra/aws/securityGroup/SecurityGroupApi'
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

const sgApi = new SecurityGroupApi()
describe('addIngressRulesのテスト', (): void => {
  test('ルールが正常な場合は追加に成功すること', async (): Promise<void> => {
    try {
      const rule: IngressSecurityGroupRule = {
        GroupId: process.env.TEST_SECURITY_GROUP_ID as string,
        DryRun: true,
        IpPermissions: [
          {
            ToPort: 80,
            FromPort: 80,
            IpProtocol: 'tcp',
            IpRanges: [
              {
                CidrIp: process.env.TEST_SOURCE_IP as string,
                Description: 'test',
              },
            ],
          },
        ],
      }
      const result = await sgApi.addIngressRule(rule)
    } catch (e) {
      // DryRunにさせているので、エラーメッセージ検証
      const errorMes = (e as Error).message
      expect(errorMes).toBe(
        'Request would have succeeded, but DryRun flag is set.',
      )
    }
  })

  test('ルールに不備があり、追加できなかった場合はfalseを返すこと', async (): Promise<void> => {
    const rule: IngressSecurityGroupRule = {
      GroupId: '',
      DryRun: true,
      IpPermissions: [
        {
          ToPort: 80,
          FromPort: 80,
          IpProtocol: 'tcp',
          IpRanges: [
            {
              CidrIp: process.env.TEST_SOURCE_IP as string,
              Description: 'test',
            },
          ],
        },
      ],
    }
    const result = await sgApi.addIngressRule(rule)
    expect(result).toBeFalsy()
  })
})
