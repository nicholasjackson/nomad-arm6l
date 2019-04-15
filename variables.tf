variable "ssh_key" {
  default = "~/.ssh/server_rsa"
}

variable "go_version" {
  default = "1.12.2"
}

variable "nomad_version" {
  description = "Nomad tag or branch to build"
  default     = "v0.9.0"
}
