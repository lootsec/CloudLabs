output "lootsec-user1_iam_user_name" {
  description = "The user's name"
  value       = element(concat(aws_iam_user.lootsec-user1.*.name, [""]), 0)
}


output "lootsec-user1_iam_access_key_id" {
  description = "The access key ID"
  value = element(concat(aws_iam_access_key.lootsec-key1.*.id, [""]), 0)
}


output "lootsec-user1_iam_access_key_secret" {
  #sensitive = true
  description = "The access key secret"
  value       = nonsensitive(element(concat(aws_iam_access_key.lootsec-key1.*.secret, [""]), 0))
} 



output "lootsec-user2_iam_user_name" {
  description = "The user's name"
  value       = element(concat(aws_iam_user.lootsec-user2.*.name, [""]), 0)
}


output "lootsec-user2_iam_access_key_id" {
  description = "The access key ID"
  value = element(concat(aws_iam_access_key.lootsec-key2.*.id, [""]), 0)
}


output "lootsec-user2_iam_access_key_secret" {
  #sensitive = true
  description = "The access key secret"
  value       = nonsensitive(element(concat(aws_iam_access_key.lootsec-key2.*.secret, [""]), 0))
} 



output "lootsec-user3_iam_user_name" {
  description = "The user's name"
  value       = element(concat(aws_iam_user.lootsec-user3.*.name, [""]), 0)
}


output "lootsec-user3_iam_access_key_id" {
  description = "The access key ID"
  value = element(concat(aws_iam_access_key.lootsec-key3.*.id, [""]), 0)
}


output "lootsec-user3_iam_access_key_secret" {
  #sensitive = true
  description = "The access key secret"
  value       = nonsensitive(element(concat(aws_iam_access_key.lootsec-key3.*.secret, [""]), 0))
} 




output "lootsec-user4_iam_user_name" {
  description = "The user's name"
  value       = element(concat(aws_iam_user.lootsec-user4.*.name, [""]), 0)
}


output "lootsec-user4_iam_access_key_id" {
  description = "The access key ID"
  value = element(concat(aws_iam_access_key.lootsec-key4.*.id, [""]), 0)
}


output "lootsec-user4_iam_access_key_secret" {
  #sensitive = true
  description = "The access key secret"
  value       = nonsensitive(element(concat(aws_iam_access_key.lootsec-key4.*.secret, [""]), 0))
} 