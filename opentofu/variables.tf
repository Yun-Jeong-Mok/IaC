variable "image_name" {
  description = "VM 생성 OS 이미지 이름"
  type        = string
  default     = "lab-rocky-9"
}

variable "key_pair_name" {
  description = "VM들 접속에 사용될 SSH 키 페어 이름"
  type        = string
  default     = "k8s-keypair"
}

variable "network_name" {
  description = "VM 네트워크 이름"
  type        = string
  default     = "net-infra"
}
