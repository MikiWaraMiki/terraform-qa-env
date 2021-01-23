import { HealthCheckSetting } from '@/domain/model/aws/targetGroup/HealthCheckSetting'

/**
 * TargetGroupを表現するクラス
 * See https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/ELBv2.html#createTargetGroup-property
 */
export class TargetGroup {
  private vpcId: string
  private name: string

  private targetGroupPort: number
  private protocol: AwsTargetGroupProtocol
  private healthCheckSetting: HealthCheckSetting

  private protocolVersion: AwsProtocolVersion = 'HTTP2'
  private tags: AwsResourceTag[] = []

  /**
   *
   * @param vpcId 設置するVpcID
   * @param name target group名
   * @param targetGroupPort target groupの待ち受けポート
   * @param protocol target groupの待ち受けプロトコろ
   * @param healthCheckSetting
   */
  constructor(
    vpcId: string,
    name: string,
    targetGroupPort: number,
    protocol: AwsTargetGroupProtocol,
    healthCheckSetting: HealthCheckSetting,
  ) {
    this.vpcId = vpcId
    this.name = name
    this.targetGroupPort = targetGroupPort
    this.protocol = protocol
    this.healthCheckSetting = healthCheckSetting
  }

  /**
   * AWSSDKに必要なリクエストに変換する
   */
  get awsApiRequestParams(): AwsTargetGroupRequestParameters {
    // tag無しでの登録はエラーを吐かせる
    if (this.tags.length < 1)
      throw Error(
        '[TargetGroup][awsApiRequestParams] unset tags please set tags',
      )

    return {
      VpcId: this.vpcId,
      Name: this.name,
      Port: this.targetGroupPort,
      Protocol: this.protocol,
      ProtocolVersion: this.protocolVersion,
      ...this.healthCheckSetting.awsApiRequestParams,
      Tags: this.tags,
    }
  }
  /**
   * TargetGroupにタグを追加する
   * @param tag 付与するタグ
   */
  addTags(tag: AwsResourceTag) {
    this.tags.push(tag)
  }

  /**
   * HTTP2にダウングレードする
   */
  downGradeProtocolHttp() {
    this.protocolVersion = 'HTTP1'
  }
}
