variable "repo_identifier" {
  type        = string
  description = "Repository"
  default = "eofaria-lab/kanastra-code-challenge-app"
}

variable "repo_branch" {
  type        = string
  description = "Branch"
  default = "main"
}

variable "eks_cluster_name" {
  description = "Cluster Name"
  type        = string
  default     = "eks-cluster-kanastra"
}

variable "codepipeline_name" {
  description = "codepipeline name"
  type        = string
  default     = "kanastra-codepipeline"
}

variable "codebuild_test_project_name" {
  description = "Kanastra Code Challenge Test Project"
  type        = string
  default     = "kanastra-codebuild-test-project"
}

variable "codebuild_lint_project_name" {
  description = "Kanastra Code Challenge Lint Project"
  type        = string
  default     = "kanastra-codebuild-lint-project"
}

variable "source_type" {
  description = "code source type"
  type        = string
  default     = "CODEPIPELINE"
}

variable "testspec" {
  description = "testspec"
  type        = string
  default     = "pipeline_files/testspec.yml"
}

variable "lintspec" {
  description = "lintspec"
  type        = string
  default     = "pipeline_files/lintspec.yml"
}

variable "ecr_repo_name" {
  description = "kanastra ecr repo name"
  type        = string
  default     = "kanastra-ecr-repo"
}

variable "codebuild_project_name" {
  description = "kanastra codebuild Project name"
  type        = string
  default     = "kanastra-codebuild-project"
}

variable "image_tag" {
  description = "image tag"
  type        = string
  default     = "latest"
}

variable "buildspec" {
  description = "buildspec"
  type        = string
  default     = "pipeline_files/buildspec.yml"
}

variable "codebuild_deploy_project_name" {
  description = "kanastra codebuild deploy Project name"
  type        = string
  default     = "kanastra-codebuild-deploy-project"
}

variable "app_name" {
  description = "app name"
  type        = string
  default     = "kanastra-app"
}

variable "deployspec" {
  description = "deployspec"
  type        = string
  default     = "pipeline_files/deployspec.yml"
}