import { AlbApiInterFace } from '@/domain/model/aws/alb/AlbApiInterface'

export class AlbApiMock implements AlbApiInterFace {
  async getAlbArn(albName: string): Promise<string | undefined> {
    const res = await albName
    return res
  }
  async getAlbUsingPortList(albArn: string): Promise<number[]> {
    const res = [10080]
    return res
  }
}
