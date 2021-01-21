/**
 * https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/ELBv2.html
 * AWS ELBv2 APIを呼び出すコアAPI
 * 関数型でそれぞれ定義されている
 */

import { ELBv2 } from 'aws-sdk'
import {
  DescribeListenersInput,
  DescribeLoadBalancersInput,
  LoadBalancer,
  Listeners,
} from 'aws-sdk/clients/elbv2'

export class AwsAlbApiCore {
  private readonly elbV2Api = new ELBv2()

  /**
   * arnで指定されたLoadBalerの詳細を返す
   * https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/EC2.html#authorizeSecurityGroupIngress-property
   * @param albArn
   */
  describeLoadBalancer = async (
    params: DescribeLoadBalancersInput,
  ): Promise<LoadBalancer | undefined> => {
    //const res = await elbV2Api.describeLoadBalancers(params).promise()
    const res = await this.elbV2Api.describeLoadBalancers(params).promise()
    if (!res.LoadBalancers) return undefined

    return res.LoadBalancers[0]
  }

  /**
   * paramsで指定された条件に該当するALBのリスナールールの一覧を返す
   * @param params
   */
  describeListeners = async (
    params: DescribeListenersInput,
  ): Promise<Listeners | undefined> => {
    const res = await this.elbV2Api.describeListeners(params).promise()
    if (!res.Listeners) return undefined

    return res.Listeners
  }
}
