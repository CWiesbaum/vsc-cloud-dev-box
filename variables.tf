variable "ssh_public_key" {
  description = "SSH Public Key file used for User"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "exposed" {
  description = "Wether or not code-server should be exposed to the internet"
  type        = bool
  default     = false
}

variable "domain" {
  description = "Domain for external access"
  type        = string
  default     = ""
}

variable "email" {
  description = "Email used for certbot"
  type        = string
  default     = ""
}

variable "test_cert" {
  description = "If certbot should run against Let's Encrypt test environment"
  type        = string
  default     = "true"
}