# 키페어 만들기
resource "tls_private_key" "k8s_ssh_key" {
  algorithm = "ED25519"
}

# 오픈스택에다가 키 등록
resource "openstack_compute_keypair_v2" "k8s_keypair" {
  name       = "k8s-keypair"
  public_key = tls_private_key.k8s_ssh_key.public_key_openssh
}

# 생성된 프라이빗 키 저장 (Ansible 접속용)
resource "local_file" "private_key_pem" {
  content         = tls_private_key.k8s_ssh_key.private_key_pem
  filename        = "/root/.ssh/id_ed25519_k8s"
  file_permission = "0400"
}
