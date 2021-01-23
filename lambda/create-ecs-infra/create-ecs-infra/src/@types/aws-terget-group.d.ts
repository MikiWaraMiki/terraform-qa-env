// target groupに指定するタイプ
declare type AwsTargetType = 'instance' | 'ip' | 'lambda'

// target groupが待ち受けるプロトコル
declare type AwsTargetGroupProtocol = 'HTTP' | 'HTTPS'
// HealthCheckに利用するプロトコル
declare type AwsTargetGroupHealthCheckProtocol = 'HTTP' | 'HTTPS'

// HTTPのバージョン
declare type AwsProtocolVersion = 'HTTP1' | 'HTTP2'

declare type AwsTargetGroupRequestParameters = {
  VpcId: string
  Name: string
  HealthCheckEnabled: boolean
  HealthCheckPath: string
  HealthCheckPort: string
  HealthCheckProtocol: AwsTargetGroupHealthCheckProtocol
  Port: number
  Protocol: AwsTargetGroupProtocol
  ProtocolVersion: AwsProtocolVersion
  Tags: AwsResourceTag[]
}
