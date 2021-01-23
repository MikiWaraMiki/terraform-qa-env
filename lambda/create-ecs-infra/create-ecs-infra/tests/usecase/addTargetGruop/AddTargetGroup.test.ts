import { HealthCheckSetting } from '@/domain/model/aws/targetGroup/HealthCheckSetting'
import { TargetGroup } from '@/domain/model/aws/targetGroup/TargetGroup'
import { addTargetGroup } from '@/usecase/addTargetGroup/AddTargetGroup'
import { TargetGroupApiMock } from './TargetGroupApiMock'

describe('AddTargetGroupのテスト', (): void => {
  test('追加に成功し場合は、arnを返すこと', async (): Promise<void> => {
    const tgApiMock = new TargetGroupApiMock()
    const res = await addTargetGroup('qa/test', 'hoge', tgApiMock)
    expect(res).toBe('test-arn')
  })
  test('brach名がから文字の場合は例外が発生すること', async (): Promise<void> => {
    const tgApiMock = new TargetGroupApiMock()
    await expect(addTargetGroup('', 'hoge', tgApiMock)).rejects.toThrow()
  })
  test('vpcIdが空文字の場合は例外が発生すること', async (): Promise<void> => {
    const tgApiMock = new TargetGroupApiMock()
    await expect(addTargetGroup('qa', '', tgApiMock)).rejects.toThrow()
  })
  test('aws sdkの処理で失敗した場合は例外が発生すること', async (): Promise<void> => {
    const tgApiMock = jest
      .fn<TargetGroupApiMock, []>()
      .mockImplementation(() => {
        return {
          addTargetGroup: async (targetGroup: TargetGroup): Promise<string> => {
            const res = await 'hoge'
            throw new Error('thrown')
          },
        }
      })
    await expect(addTargetGroup('qa', 'wa', new tgApiMock())).rejects.toThrow()
  })
})
