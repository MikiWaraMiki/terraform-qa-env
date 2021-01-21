/**
 * AlbApi.tsのテストコード
 * AWS APIで、AWS環境情報を取得するため、
 * 事前にAWSのインフラ構成を作成しておく必要があります。
 */
import { AlbApi } from '@/infra/aws/alb/AlbApi'
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

const albApi = new AlbApi()
const TARGET_ALB_NAME = 'alb-sample-qa-create'
describe('getAlbArnのテスト', (): void => {
  test('存在するALB名の場合は、ARN返却すること', async (): Promise<void> => {
    const arn = await albApi.getAlbArn(TARGET_ALB_NAME)
    expect(arn).toBeDefined()
  })
  test('存在しないALB名の場合は、Exceptionが発生すること', async (): Promise<void> => {
    const arn = await albApi.getAlbArn('hogehoge')
    expect(arn).toBeUndefined
  })
})

describe('getAlbUsingPortListのテスト', (): void => {
  test('存在するarnが指定されている場合は、利用しているportの一覧を返す', async (): Promise<void> => {
    const arn = await albApi.getAlbArn(TARGET_ALB_NAME)
    const portList = await albApi.getAlbUsingPortList(arn || '')
    expect(portList).toBeInstanceOf(Array)
  })

  test('存在しないarnが指定された場合は、例外が発生する', async (): Promise<void> => {
    await expect(albApi.getAlbUsingPortList('hogehoge')).rejects.toThrow()
  })
})

describe('getAlbUsingSecurityGroupIdListのテスト', (): void => {
  test('arnが存在するALBを示していた場合は、security groupのid配列返却される', async (): Promise<void> => {
    const arn = await albApi.getAlbArn(TARGET_ALB_NAME)
    const securityGroupList = await albApi.getAlbUsingSecurityGroupIdList(
      arn || '',
    )
    expect(securityGroupList).toBeInstanceOf(Array)
  })
  test('arnが存在しないALBを示していた場合は、例外が発生すること', async (): Promise<void> => {
    const arn = 'hogehoge'
    await expect(albApi.getAlbUsingSecurityGroupIdList(arn)).rejects.toThrow()
  })
})
