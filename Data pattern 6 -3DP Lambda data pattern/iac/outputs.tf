output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group."
  value       = module.lambda_ingestion.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch log group."
  value       = module.lambda_ingestion.cloudwatch_log_group_arn
}

/*----------------------------------------------------------------------------*/

output "function_names" {
  description = "The names of the Lambda functions."
  value       = module.lambda_ingestion.function_names
}

output "function_arns" {
  description = "The ARNs of the Lambda functions."
  value       = module.lambda_ingestion.function_arns
}

output "function_role_arns" {
  description = "The ARNs of the IAM roles used by the Lambda functions."
  value       = module.lambda_ingestion.function_role_arns
}
    output "function_security_group_ids" {
      description = "The IDs of the security groups created for the Lambda functions."
      value       = module.lambda_ingestion.function_security_group_ids
    }

    output "function_dlq_arns" {
      description = "The ARNs of the Dead Letter Queues (DLQs) used by the Lambda functions."
      value       = module.lambda_ingestion.function_dlq_arns
    }

    output "function_failure_alerts_topic_arns" {
      description = "The ARN of the SNS topic for Lambda function failure alerts."
      value       = module.lambda_ingestion.function_failure_alerts_topic
    }

    output "function_failure_cloudwatch_alarm_arns" {
      description = "The ARNs of the Cloudwatch alarms for Lambda function failure alerts."
      value       = module.lambda_ingestion.function_failure_cloudwatch_a
    }

    output "function_application_emails_topic_arns" {
      description = "The ARNs of the SNS topics for application emails."
      value       = module.lambda_ingestion.function_application_emails_t
    }

    /*-----------------------------------------------------------------------------*/
        output "kms_key_id" {
      description = "The ID of the KMS key."
      value       = module.lambda_ingestion.kms_key_id
    }

    output "kms_key_arn" {
      description = "The ARN of the KMS key."
      value       = module.lambda_ingestion.kms_key_arn
    }

    output "kms_key_alias_id" {
      description = "The ID of the KMS key alias."
      value       = module.lambda_ingestion.kms_key_alias_id
    }

    output "kms_key_alias_arn" {
      description = "The ARN of the KMS key alias."
      value       = module.lambda_ingestion.kms_key_alias_arn
    }

    /*----------------------------------------------------------------------*/

    output "data_bucket_id" {
      description = "The name (ID) of the bucket."
      value       = module.lambda_ingestion.bucket_id
    }
    output "data_bucket_arn" {
  description = "The ARN of the bucket."
  value       = module.lambda_ingestion.bucket_arn
}

output "data_bucket_access_points" {
  description = "Details of created S3 access points."
  value       = module.lambda_ingestion.access_points
}

/*---------------------------------------------------------------------------*/

output "secret_name" {
  description = "The name of the secret."
  value       = module.lambda_ingestion.secret_name
}

output "secret_arn" {
  description = "The ARN of the secret."
  value       = module.lambda_ingestion.secret_arn
}

output "secret_version_id" {
  description = "The version ID of the current secret."
  value       = module.lambda_ingestion.secret_version_id
}
output "secret_version_arn" {
  description = "The ARN of the secret version."
  value       = module.lambda_ingestion.secret_version_arn
}