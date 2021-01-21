import { IngressSecurityGroupRule } from '@/domain/model/aws/securityGroup/IngressSecurityGroupRule'

export interface SecurityGroupApiInterface {
  addIngressRule(rule: IngressSecurityGroupRule): Promise<boolean>
}
