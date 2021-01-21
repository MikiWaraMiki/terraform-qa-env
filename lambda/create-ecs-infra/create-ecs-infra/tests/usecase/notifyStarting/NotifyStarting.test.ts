/**
 * @/usecase/notifyStartingのユニットテスト
 */
import { notifyStarting } from '@/usecase/notifyStarting/NotifyStarting'
import { SlackWebHookMock } from './SlackWebHookMock'

const slackWebhookMock = new SlackWebHookMock()
describe('notifyStartingのユニットテスト', (): void => {
  test('200を返すこと', async (): Promise<void> => {
    try {
      const res = await notifyStarting(slackWebhookMock, 'hogehoge')
      expect(res).toBe(200)
    } catch (e) {
      console.error(e)
    }
  })
})
