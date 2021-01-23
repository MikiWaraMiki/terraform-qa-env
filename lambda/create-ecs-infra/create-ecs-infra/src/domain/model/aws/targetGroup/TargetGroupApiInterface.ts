import { TargetGroup } from '@/domain/model/aws/targetGroup/TargetGroup'

export interface TargetGroupApiInterface {
  addTargetGroup(targetGroup: TargetGroup): Promise<string>
}
