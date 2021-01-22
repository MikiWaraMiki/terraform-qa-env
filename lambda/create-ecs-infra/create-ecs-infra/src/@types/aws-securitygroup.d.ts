/**
 * Security Group Rule Inboundの定義
 * See https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/EC2.html#authorizeSecurityGroupIngress-property
 */
declare type AwsSecurityGroupProtocol = 'tcp' | 'udp' | 'icmp' | 'icmpv6'
declare type AwsRequestSourceIpRule = {
  CidrIp: string
  Description: string
}
declare type AwsRequestSourceSecurityGroupRule = {
  GroupId: string
  Description: string
}
declare type AwsRequestIpPermissions = {
  FromPort: number
  ToPort: number
  IpProtocol: 'tcp' | 'udp' | 'icmp' | 'icmpv6'
  IpRanges?: IpRange[]
  UserIdGroupPairs?: SourceSecurityGroupRule[]
  Ipv6Ranges?: IpV6Range[]
}
declare type AwsIngressSecurityGroupRule = {
  GroupId: string
  IpPermissions: IpPermissions[]
  DryRun?: boolean
}
