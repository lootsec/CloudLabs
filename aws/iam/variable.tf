variable "name1" {
  description = "Desired name for the IAM user"
  type        = string
  default     = "looter1"
}

variable "name2" {
  description = "Desired name for the IAM user"
  type        = string
  default     = "looter2"
}

variable "name3" {
  description = "Desired name for the IAM user"
  type        = string
  default     = "looter3"
}

variable "name4" {
  description = "Desired name for the IAM user"
  type        = string
  default     = "looter4"
}

variable "group-name1" {
  description = "Name of IAM group"
  type        = string
  default     = "looter-group1"
}

variable "group_users1" {
  description = "List of IAM users to have in an IAM group"
  type        = list(string)
  default     = ["looter1","looter3"]
}
