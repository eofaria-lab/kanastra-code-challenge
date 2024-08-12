resource "aws_s3_bucket" "kanastra_codepipeline_bucket" {
  bucket = "code-pipeline-${local.region}-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "codepipeline_s3_sse" {
  bucket = aws_s3_bucket.kanastra_codepipeline_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "cpl_bkt_block_public_access" {
  bucket = aws_s3_bucket.kanastra_codepipeline_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_codestarconnections_connection" "kanastra-github" {
  name          = "kanastra-github"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "kanastra_codepipeline" {
  name     = var.codepipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.kanastra_codepipeline_bucket.bucket
    type     = "S3"

  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]


      configuration = {
        FullRepositoryId = var.repo_identifier
        BranchName       = var.repo_branch
        ConnectionArn = aws_codestarconnections_connection.kanastra-github.arn
      }
    }
  }

  stage {
    name = "Test"

    action {
      name             = "Test"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["test_output"]
      configuration = {
        ProjectName = aws_codebuild_project.kanastra-codebuild-test-project.name
      }
    }
    action {
      name             = "Lint"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["lint_output"]
      configuration = {
        ProjectName = aws_codebuild_project.kanastra_codebuild_lint_project.name
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.kanastra_codebuild_project.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["deploy_output"]
      configuration = {
        ProjectName = aws_codebuild_project.kanastra_codebuild_deploy_project.name
      }
    }
  }

}
