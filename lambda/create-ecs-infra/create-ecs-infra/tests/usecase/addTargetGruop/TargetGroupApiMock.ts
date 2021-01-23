import { TargetGroup } from '@/domain/model/aws/targetGroup/TargetGroup'
import { TargetGroupApiInterface } from '@/domain/model/aws/targetGroup/TargetGroupApiInterface'

export class TargetGroupApiMock implements TargetGroupApiInterface {
  async addTargetGroup(targetGroup: TargetGroup): Promise<string> {
    const res = await 'test-arn'
    return res
  }
}
