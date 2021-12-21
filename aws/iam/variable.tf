variable "name1" {
  description = "Desired name for the IAM user"
  type        = string
  default     = "lootsec-user1"
}

variable "name2" {
  description = "Desired name for the IAM user"
  type        = string
  default     = "lootsec-user2"
}

variable "name3" {
  description = "Desired name for the IAM user"
  type        = string
  default     = "lootsec-user3"
}

variable "name4" {
  description = "Desired name for the IAM user"
  type        = string
  default     = "lootsec-user4"
}

variable "group-name1" {
  description = "Name of IAM group"
  type        = string
  default     = "lootsec-group1"
}

variable "group_users1" {
  description = "List of IAM users to have in an IAM group"
  type        = list(string)
  default     = ["lootsec-user1","lootsec-user3"]
}
