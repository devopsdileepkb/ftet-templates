locals {
  /* Set project name as local to force consistency across all deployment environments. */
  project_name = "${{ values.ProjectName }}"

  /* Set region as local to force consistency across all deployment environments. */
  region = "${{ values.Region }}"
}