output "looter1_iam_user_name" {
  description = "The user's name"
  value       = element(concat(aws_iam_user.looter1.*.name, [""]), 0)
}


output "looter1_iam_access_key_id" {
  description = "The access key ID"
  value = element(concat(aws_iam_access_key.looter-key1.*.id, [""]), 0)
}


output "looter1_iam_access_key_secret" {
  #sensitive = true
  description = "The access key secret"
  value       = nonsensitive(element(concat(aws_iam_access_key.looter-key1.*.secret, [""]), 0))
} 



output "looter2_iam_user_name" {
  description = "The user's name"
  value       = element(concat(aws_iam_user.looter2.*.name, [""]), 0)
}


output "looter2_iam_access_key_id" {
  description = "The access key ID"
  value = element(concat(aws_iam_access_key.looter-key2.*.id, [""]), 0)
}


output "looter2_iam_access_key_secret" {
  #sensitive = true
  description = "The access key secret"
  value       = nonsensitive(element(concat(aws_iam_access_key.looter-key2.*.secret, [""]), 0))
} 



output "looter3_iam_user_name" {
  description = "The user's name"
  value       = element(concat(aws_iam_user.looter3.*.name, [""]), 0)
}


output "looter3_iam_access_key_id" {
  description = "The access key ID"
  value = element(concat(aws_iam_access_key.looter-key3.*.id, [""]), 0)
}


output "looter3_iam_access_key_secret" {
  #sensitive = true
  description = "The access key secret"
  value       = nonsensitive(element(concat(aws_iam_access_key.looter-key3.*.secret, [""]), 0))
} 




output "looter4_iam_user_name" {
  description = "The user's name"
  value       = element(concat(aws_iam_user.looter4.*.name, [""]), 0)
}


output "looter4_iam_access_key_id" {
  description = "The access key ID"
  value = element(concat(aws_iam_access_key.looter-key4.*.id, [""]), 0)
}


output "looter4_iam_access_key_secret" {
  #sensitive = true
  description = "The access key secret"
  value       = nonsensitive(element(concat(aws_iam_access_key.looter-key4.*.secret, [""]), 0))
} 