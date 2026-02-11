#################################################################
########################### REQUIRED ###########################
#################################################################

/*--------------------------Environment Information --------------------------*/

variable "env" {
  description = <<DOC
    The environment of the current deployment.
    This can be retrieved from the workflow if using FTET reusable workflows and 
    does not need to be set in tfvars.
    The resources created by this module will be named according to this environment.
DOC
  type        = string
  nullable    = false
}

variable "project" {
  description = <<DOC
    The name of the project repository.
    This can be retrieved from the workflow if using FTET reusable workflows and 
    does not need to be set in tfvars.
    This is used to tag resources created by this module.
DOC
  type        = string
  nullable    = false
}

/*--------------------------Network --------------------------*/

variable "subnet_ids" {
    description = <<DOC
    A list of subnet IDs for the Lambda functions.
    Used to determine the VPC configuration for the project.
    DOC
    type     = list(string)
    nullable = false
}

/*--------------------------------Alerting--------------------------------*/

variable "infrastructure_notification_emails" {
  description = "A list of email addresses to notify on Lambda function failures."
  type        = list(string)
  nullable    = false
}

############################################################################
############################### TOGGLES ####################################
############################################################################

############################################################################
############################### OPTIONAL ###################################
############################################################################

/*--------------------------------Alerting--------------------------------*/

variable "application_notification_emails" {
    description = "A list of email addresses to notify on custom Lambda function alerts."
  type        = list(string)
  default     = []
  nullable    = false
}

/*--------------------------------Function Config--------------------------------*/

variable "functions_configs" {
  description = <<DOC
  Configuration for the Lambda functions.
  DOC
  type = list(object({
    name                  = string
    runtime               = string
    handler               = string
    uses_image            = bool
    create_lambda_archive = bool
    create_lambda_image   = bool
    application_directory = optional(string)
    archive_path          = optional(string)
    dockerfile_path       = optional(string)
    image_uri             = optional(string)
    image_tag             = optional(string)
    security_group_ids    = optional(list(string))
    ingress_rules = optional(list(object({
      ip_protocol = string
      from_port   = optional(number, null)
      to_port     = optional(number, null)
      description              = string
      cidr_ipv4                = optional(string, null)
      cidr_ipv6                = optional(string, null)
      prefix_list_id           = optional(string, null)
      referenced_security_group_id = optional(string, null)
    })))
    egress_rules = optional(list(object({
      ip_protocol = string
      from_port   = optional(number, null)
      to_port     = optional(number, null)
      description = string
      cidr_ipv4   = optional(string, null)
      cidr_ipv6   = optional(string, null)
      prefix_list_id = optional(string, null)
      referenced_security_group_id = optional(string, null)
    })))
    job_policy                  = optional(string, "")
    timeout                     = optional(number, 900)
    reserved_concurrent_executions = optional(number)
    memory_size                 = optional(number, 128)
    environment_variables       = optional(map(string))
    layer_names                 = optional(list(string), [])
  }))
  default  = []
  nullable = false
}

/*--------------------------------Layer Config --------------------------------*/
variable "layers_configs" {
  description = "A list of configurations for the Lambda layers."
  type = list(object({
    name                  = string
    description           = optional(string, "A layer for the Lambda Ingestion pattern.")
    requirements_file_path = string
    compatible_runtimes   = list(string)
  }))
  default  = []
  nullable = false
}

/*--------------------------------Storage Config --------------------------------*/

variable "data_staging_bucket_config" {
  description = <<DOC
  Configuration for the S3 bucket used for staging data.
  This bucket is used to store intermediate data during Lambda function.
  DOC
  type = object({
    bucket_force_destroy = optional(bool, false)
    bucket_lifecycle_rules = list(object({
      id     = string
      status = string

      abort_incomplete_multipart_upload = optional(object({
        days_after_initiation = optional(number)
      }))
      expiration = optional(object({
        days = number
      }))

      transition = optional(object({
        days          = number
        storage_class = string
      }))

      noncurrent_version_expiration = optional(object({
        days = number
      }))

      noncurrent_version_transition = optional(object({
        days             = number
        storage_class    = string
        newer_noncurrent_versions = optional(number)
      }))

      filter = optional(object({
        prefix = string
      }))
    }))
    access_point_definitions = optional(list(object({
      name    = string
      prefix  = list(string)
      roles   = list(string)
      actions = list(string)
    })))
    })
default = {
bucket_force_destroy = false
bucket_lifecycle_rules = [
{
id      = "DefaultExpiration"
status  = "Enabled"
expiration = {
days = 90
}
}
]
access_point_definitions = []
}
nullable = false
}
/*-------------------------------Secret Config -------------------------------*/
variable "secrets_configs" {
description = "List of secret configurations for JDBC credentials."
type = list(object({
name          = string
secret_string = string
}))
default  = []
nullable = false
}
/*------------------------------------------KMS Config------------------------------------------*/

variable "kms_key_config" {
  description = <<DOC
  Configuration for the KMS key used for encrypting this pattern's resources.
  This key will be used in the Lambda function to encrypt environment variables,
  data staging bucket, Cloudwatch Logs, and Secrets.
  DOC
  type = object({
    deletion_window_in_days      = optional(number, 7)
    rotation_period              = optional(number, 90)
    custom_policy_json_document  = optional(string, "")
  })
  default = {
    deletion_window_in_days      = 7
    rotation_period              = 90
    custom_policy_json_document  = ""
  }
  nullable = false
}

/*-----------------------------------------Access Config-----------------------------------------*/

variable "ops_roles_arns" {
  description = "List of IAM role ARNs with operations access."
  type        = list(string)
  default     = []
  nullable    = false
}