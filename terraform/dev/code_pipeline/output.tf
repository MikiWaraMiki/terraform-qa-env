output "code_build_role_id" {
  description = "created codebuild role id"
  value       = module.codebuild_iam_role.id
}
output "code_build_policy_id" {
  description = "created codebuild policy id"
  value       = module.codebuild_iam_policy.id
}
output "codebuild_id" {
  description = "created codebuild id"
  value       = module.codebuild.id
}
output "codepipeline_role_id" {
  description = "created codepipeline role id"
  value       = module.codepipeline_role.id
}
output "codepipeline_policy_id" {
  description = "creted codepipeline policy arn"
  value       = module.codepipeline_policy.arn
}
output "s3_for_codepipeline_id" {
  description = "created s3 id"
  value       = module.s3_for_pipeline.id
}
output "s3_for_codepipeline_domain_name" {
  description = "created s3 domain name"
  value       = module.s3_for_pipeline.bucket_domain_name
}
