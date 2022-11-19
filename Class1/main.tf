resource "aws_iam_user" "andrew" {
  name = "andrew"
}

resource "aws_iam_user_login_profile" "andrew" {
  user    = aws_iam_user.andrew.name
  password_length = 46
  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}
