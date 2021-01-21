import { ELBv2 } from 'aws-sdk'
import { AlbApiInterFace } from '@/domain/model/aws/alb/AlbApiInterface'
import { createLambdaLogger } from '@/util/logger'
import { listeners } from 'process'
import { AwsAlbApiCore } from '@/infra/aws/alb/AwsAlbApiCore'

export class AlbApi implements AlbApiInterFace {
  private readonly albCoreApi = new AwsAlbApiCore()
  private readonly logger = createLambdaLogger()
  /**
   * ALB名からARNを取得する関数
   * @param albName arnを取得するALB名
   * @returns 取得した場合はarn, 取得できなかった場合はundefined
   */
  async getAlbArn(albName: string): Promise<string | undefined> {
    try {
      const params = {
        Names: [albName],
      }
      this.logger.log({
        level: 'info',
        message: `[AlbApi][getAlbArn] call describeLoadBalancers. name: ${albName}`,
      })
      const res = await this.albCoreApi.describeLoadBalancer(params)
      // response チェック
      if (!res)
        throw new Error(`response is not include LoadBalancer Property. ${res}`)
      const responseJson = JSON.stringify(res)
      this.logger.log({
        level: 'info',
        message: `[AlbApi][getAlbArn] aws response is success. response: ${responseJson}`,
      })
      return res.LoadBalancerArn
    } catch (e) {
      const message = e instanceof Error ? e.message : e
      this.logger.log({
        level: 'error',
        message: `[AlbApi][getAlbArn] exception, ${message}`,
      })
      return undefined
    }
  }

  /**
   * ALBが利用しているポートのリストを返す
   * @param albArn
   */
  async getAlbUsingPortList(albArn: string): Promise<number[]> {
    const params = {
      LoadBalancerArn: albArn,
    }
    this.logger.log({
      level: 'info',
      message: '[AlbApi][getAlbUsingPortList] call describe Listenner.',
    })
    try {
      const res = await this.albCoreApi.describeListeners(params)
      if (!res) {
        throw new Error(
          `[AlbApi][getAlbUsingPortList] alb is not found, arn: ${albArn}`,
        )
      }

      const portList = res.map((listener) => listener.Port)
      // undefinedの物を取り除く
      const usingPortList = portList.filter(
        (port): port is number => typeof port === 'number',
      )
      return usingPortList
    } catch (e) {
      const message = e instanceof Error ? e.message : e
      this.logger.log({
        level: 'error',
        message: `[AlbApi][getAlbUsingPortList] cannot get alb arn. exception: ${message}`,
      })
      throw e
    }
  }

  /**
   * ALBにアタッチされているSGのidを返す
   */
  async getAlbUsingSecurityGroupIdList(albArn: string): Promise<string[]> {
    try {
      const params = {
        LoadBalancerArns: [albArn],
      }

      const res = await this.albCoreApi.describeLoadBalancer(params)
      if (!res) {
        this.logger.log({
          level: 'error',
          message: `[AlbApi][getAlbUsingSecurityGroupId] alb is not found. arn ${albArn}`,
        })
        throw Error(
          '[AlbApi][getAlbUsingSecurityGroupId] alb is not found. arn ${albArn}',
        )
      }

      if (!res.SecurityGroups) return []

      this.logger.log({
        level: 'info',
        message: `[AlbApi][getAlbUsingSecurityGroupId] security group ids: ${res.SecurityGroups.join(
          ',',
        )}`,
      })

      return res.SecurityGroups
    } catch (e) {
      const errorMes = (e as Error).message
      this.logger.log({
        level: 'error',
        message: `[AlbApi][getAlbUsingSecurityGroupId] cannot get security group ids, ${errorMes}`,
      })
      throw e
    }
  }
}
