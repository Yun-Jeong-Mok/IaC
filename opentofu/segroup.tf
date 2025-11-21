# k8s 클러스터 보안 그룹 생성
resource "openstack_networking_secgroup_v2" "k8s_security_group" {
  name        = "k8s-cluster-sg"
  description = "Security group for Kubernetes cluster nodes (HAProxy, Control, Worker)."
}

# SSH 접속 허용 (모든 노드)
resource "openstack_networking_secgroup_rule_v2" "ssh_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.k8s_security_group.id
}

# Kube API Server 외부 접근 허용 <-  HAproxy로 로드밸런싱
resource "openstack_networking_secgroup_rule_v2" "kube_api_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6443
  port_range_max    = 6443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.k8s_security_group.id
}

# 노드포트 전부 열기
resource "openstack_networking_secgroup_rule_v2" "nodeport_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 30000
  port_range_max    = 32767
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.k8s_security_group.id
}

# 클러스터 내부 통신은 다 허용 
resource "openstack_networking_secgroup_rule_v2" "k8s_internal_ingress_all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = ""
  remote_group_id   = openstack_networking_secgroup_v2.k8s_security_group.id
  security_group_id = openstack_networking_secgroup_v2.k8s_security_group.id
}
