/**
 * Security Group Rule Inboundの定義
 * See https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/EC2.html#authorizeSecurityGroupIngress-property
 */
type IpV6Range = {
  CidrIpv6: string
  Description: string
}
type IpRange = {
  CidrIp: string
  Description: string
}
type SourceSecurityGroupRule = {
  GroupId: string
  Description: string
}
type IpPermissions = {
  FromPort: number
  ToPort: number
  IpProtocol: 'tcp' | 'udp' | 'icmp' | 'icmpv6'
  IpRanges?: IpRange[]
  UserIdGroupPairs?: SourceSecurityGroupRule[]
  Ipv6Ranges?: IpV6Range[]
}
export type IngressSecurityGroupRule = {
  GroupId: string
  IpPermissions: IpPermissions[]
  DryRun?: boolean
}
