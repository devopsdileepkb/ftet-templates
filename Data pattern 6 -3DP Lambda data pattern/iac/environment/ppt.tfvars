 # Use variables to change configurations between environments.

 infrastructure_notification_emails = ${{ values.InfrastructureEmails }}

 application_notification_emails = ${{ values.InfrastructureEmails }}

 functions_configs = [
   {
     name                           = "my_function"
     runtime                        = "python3.10"
     handler                        = "lambda.lambda_handler"
     uses_image                     = false
     create_lambda_archive          = true
     create_lambda_image            = false
     application_directory          = "../src/lambda/"
     archive_path                   = null
     dockerfile_path                = null
     image_uri                      = null
     image_tag                      = null
     security_group_ids             = []
     ingress_rules                  = []
     egress_rules                   = []
     job_policy                     = ""
     timeout                        = 900
     reserved_concurrent_executions = 3
     memory_size                    = 128
     environment_variables = {
     "key" = "value"
     }
        layer_names = ["layer_1"]
    }
]

layers_configs = [
    {
        name                    = "layer_1"
        description             = ""
        requirements_file_path  = "../src/requirements.txt"
        compatible_runtimes     = ["python3.10"]
    }
]

data_staging_bucket_config = {
    bucket_force_destroy = true
    bucket_lifecycle_rules = [
        {
            id         = "ExpireAfter90"
            status     = "Enabled"
            expiration = {
                days = 90
            }
        }
    ]
access_point_definitions = [
    {
        name   = "MyAccessPoint"
        prefix = ["PathA/"]
        roles  = [data.aws_iam_roles.lambda.arns]
      actions = [
        "s3:GetObject",
        "s3:PutObject"
      ]
    }
  ]
}

secrets_configs = [
  {
    name          = "credentials"
    secret_string = var.super_secret_string
  }
]

kms_key_config = {
  kms_key_deletion_window_in_days = 7
  kms_key_rotation_period         = 90
  kms_key_policy_json_document    = ""
}

ops_roles_arns = []