module "lambda_ingestion" {
  /* Provides a Lambda Ingestion pattern configuration.
  https://github.com/AZU-RDIT/ftet-terraform-modules/tree/master/patterns/3dp-lambda-ingestion-tf-pattern */
  source = "../ftet-terraform-modules/patterns/3dp-lambda-ingestion-tf-pattern"

  ####################################### Required #######################################

  env                             = var.env
  project_name                   = local.project_name
  subnet_ids                     = data.aws_subnets.private.ids
  infrastructure_notification_emails = var.infrastructure_notification_emails

  ####################################### Toggles ########################################

  ####################################### Optional #######################################

  /*---------------------------------------Alerting---------------------------------------*/

  application_notification_emails = var.application_notification_emails

  /*------------------------------------Function Config-----------------------------------*/

  functions_configs = var.functions_configs

  /*-------------------------------------Layer Config-------------------------------------*/
         
   layers_configs = var.layers_configs

   /*---------------------------------Storage Config---------------------------------*/

    data_staging_bucket_config = var.data_staging_bucket_config

   /*---------------------------------Secret Config----------------------------------*/

    secrets_configs = var.secrets_configs

    /*---------------------------------KMS Config-------------------------------------*/

    kms_key_config = var.kms_key_config

    /*---------------------------------Access Config----------------------------------*/

    ops_roles_arns = var.ops_roles_arns
       }