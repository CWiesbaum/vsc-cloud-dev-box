variable "ssh_public_key" {
  description = "SSH Public Key file used for User"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
