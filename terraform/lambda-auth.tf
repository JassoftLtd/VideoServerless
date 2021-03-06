// Auth
resource "aws_lambda_function" "createUser" {
  depends_on = [
    "aws_iam_role_policy.LambdAuthCreateUser",
  ]

  filename         = "${path.module}/PackagedLambdas/CreateUser.zip"
  function_name    = "LambdAuthCreateUser"
  role             = "${aws_iam_role.LambdAuthCreateUser.arn}"
  handler          = "CreateUser.handler"
  runtime          = "nodejs6.10"
  timeout          = "30"
  memory_size      = "256"
  source_code_hash = "${base64sha256(file("${path.module}/PackagedLambdas/CreateUser.zip"))}"
  kms_key_arn      = "${aws_kms_key.lambda_variables.arn}"

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      auth_db_table           = "${aws_dynamodb_table.users-table.name}"
      subscriptions_db_table  = "${aws_dynamodb_table.subscriptions-table.name}"
      cameras_db_table        = "${aws_dynamodb_table.cameras-table.name}"
      auth_application_name   = "${var.application_name}"
      auth_verification_page  = "https://${var.environment_subdomain}${var.domain_name}/verify"
      auth_email_from_address = "${var.auth_email_from_address}"
    }
  }
}

resource "aws_lambda_function" "changePassword" {
  depends_on = [
    "aws_iam_role_policy.LambdAuthChangePassword",
  ]

  filename         = "${path.module}/PackagedLambdas/ChangePassword.zip"
  function_name    = "LambdAuthChangePassword"
  role             = "${aws_iam_role.LambdAuthChangePassword.arn}"
  handler          = "ChangePassword.handler"
  runtime          = "nodejs6.10"
  timeout          = "30"
  memory_size      = "256"
  source_code_hash = "${base64sha256(file("${path.module}/PackagedLambdas/ChangePassword.zip"))}"
  kms_key_arn      = "${aws_kms_key.lambda_variables.arn}"

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      auth_db_table = "${aws_dynamodb_table.users-table.name}"
    }
  }
}

resource "aws_lambda_function" "login" {
  depends_on = [
    "aws_iam_role_policy.LambdAuthLogin",
  ]

  filename         = "${path.module}/PackagedLambdas/Login.zip"
  function_name    = "LambdAuthLogin"
  role             = "${aws_iam_role.LambdAuthLogin.arn}"
  handler          = "Login.handler"
  runtime          = "nodejs6.10"
  timeout          = "30"
  memory_size      = "256"
  source_code_hash = "${base64sha256(file("${path.module}/PackagedLambdas/Login.zip"))}"
  kms_key_arn      = "${aws_kms_key.lambda_variables.arn}"

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      auth_db_table                = "${aws_dynamodb_table.users-table.name}"
      auth_identity_pool           = "${var.aws_identity_pool}"
      auth_developer_provider_name = "${var.auth_developer_provider_name}"
    }
  }
}

resource "aws_lambda_function" "loginCameraKey" {
  depends_on = [
    "aws_iam_role_policy.LambdAuthLoginCameraKey",
  ]

  filename         = "${path.module}/PackagedLambdas/CameraKeyAuth.zip"
  function_name    = "CameraKeyAuth"
  role             = "${aws_iam_role.LambdAuthLoginCameraKey.arn}"
  handler          = "CameraKeyAuth.handler"
  runtime          = "nodejs6.10"
  timeout          = "30"
  memory_size      = "256"
  source_code_hash = "${base64sha256(file("${path.module}/PackagedLambdas/CameraKeyAuth.zip"))}"
  kms_key_arn      = "${aws_kms_key.lambda_variables.arn}"

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      auth_identity_pool           = "${var.aws_identity_pool}"
      auth_developer_provider_name = "${var.auth_developer_provider_name}"
    }
  }
}

resource "aws_lambda_function" "lostPassword" {
  depends_on = [
    "aws_iam_role_policy.LambdAuthLostPassword",
  ]

  filename         = "${path.module}/PackagedLambdas/LostPassword.zip"
  function_name    = "LambdAuthLostPassword"
  role             = "${aws_iam_role.LambdAuthLostPassword.arn}"
  handler          = "LostPassword.handler"
  runtime          = "nodejs6.10"
  timeout          = "30"
  memory_size      = "256"
  source_code_hash = "${base64sha256(file("${path.module}/PackagedLambdas/LostPassword.zip"))}"
  kms_key_arn      = "${aws_kms_key.lambda_variables.arn}"

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      auth_db_table           = "${aws_dynamodb_table.users-table.name}"
      auth_application_name   = "${var.application_name}"
      auth_reset_page         = "https://${var.environment_subdomain}${var.domain_name}/reset"
      auth_email_from_address = "${var.auth_email_from_address}"
    }
  }
}

resource "aws_lambda_function" "resetPassword" {
  depends_on = [
    "aws_iam_role_policy.LambdAuthResetPassword",
  ]

  filename         = "${path.module}/PackagedLambdas/ResetPassword.zip"
  function_name    = "LambdAuthResetPassword"
  role             = "${aws_iam_role.LambdAuthResetPassword.arn}"
  handler          = "ResetPassword.handler"
  runtime          = "nodejs6.10"
  timeout          = "30"
  memory_size      = "256"
  source_code_hash = "${base64sha256(file("${path.module}/PackagedLambdas/ResetPassword.zip"))}"
  kms_key_arn      = "${aws_kms_key.lambda_variables.arn}"

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      auth_db_table = "${aws_dynamodb_table.users-table.name}"
    }
  }
}

resource "aws_lambda_function" "verifyUser" {
  depends_on = [
    "aws_iam_role_policy.LambdAuthVerifyUser",
  ]

  filename         = "${path.module}/PackagedLambdas/VerifyUser.zip"
  function_name    = "LambdAuthVerifyUser"
  role             = "${aws_iam_role.LambdAuthVerifyUser.arn}"
  handler          = "VerifyUser.handler"
  runtime          = "nodejs6.10"
  timeout          = "30"
  memory_size      = "256"
  source_code_hash = "${base64sha256(file("${path.module}/PackagedLambdas/VerifyUser.zip"))}"
  kms_key_arn      = "${aws_kms_key.lambda_variables.arn}"

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      auth_db_table = "${aws_dynamodb_table.users-table.name}"
    }
  }
}
