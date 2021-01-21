import { useAblePortList } from '@/domain/model/aws/alb/UseAbleAlbPort'
import { getAlbEmptyPort } from '@/usecase/getALbEmptyPort/GetAlbEmptyPort'
import { AlbApiMock } from './AlbApiMock'

describe('getAlbEmptyPortのテスト', (): void => {
  test('空きポートが空いている場合は、ポート番号を返すこと', async (): Promise<void> => {
    const expectedResult = useAblePortList.filter((port) => port !== 10080)
    // AWS APIの正常系Mock(AlbApiMockをベースにする)
    const awsApi = new AlbApiMock()
    const result = await getAlbEmptyPort(awsApi, 'alb_mock')

    expect(result).not.toBeUndefined()
    expect(result).toBe(expectedResult[0])
  })

  test('空きポートが存在しない場合は、例外が発生すること', async (): Promise<void> => {
    // AlbApiMockをベースにして全てのポートを使っているパターン
    const fullPortApiMock = jest.fn<AlbApiMock, []>().mockImplementation(() => {
      return {
        getAlbArn: async (albName: string): Promise<string | undefined> => {
          const res = await albName
          return res
        },
        getAlbUsingPortList: async (albArn: string): Promise<number[]> => {
          const res = await useAblePortList
          return res
        },
      }
    })
    const awsApi = new fullPortApiMock()

    await expect(getAlbEmptyPort(awsApi, 'alb_mock')).rejects.toThrow()
  })
})
