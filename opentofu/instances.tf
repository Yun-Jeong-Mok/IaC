# HAProxy 서버용 Flavor
data "openstack_compute_flavor_v2" "haproxy_flavor" {
  name = "m1.medium"
}

# 컨트롤 노드 및 워커 노드용 Flavor
data "openstack_compute_flavor_v2" "k8s_node_flavor" {
  name = "t1.kubernetes"
}

# HAProxy 인스턴스 1대 생성
resource "openstack_compute_instance_v2" "haproxy_server" {
  name            = "haproxy"
  flavor_id       = data.openstack_compute_flavor_v2.haproxy_flavor.id
  image_name      = var.image_name
  key_pair        = openstack_compute_keypair_v2.k8s_keypair.name
  security_groups = [openstack_networking_secgroup_v2.k8s_security_group.name]
  network {
    name = var.network_name
  }
}

# 컨트롤 노드 3대 생성
resource "openstack_compute_instance_v2" "control_plane" {
  count           = 3
  name            = "control${count.index + 1}"
  flavor_id       = data.openstack_compute_flavor_v2.k8s_node_flavor.id
  image_name      = var.image_name
  key_pair        = openstack_compute_keypair_v2.k8s_keypair.name
  security_groups = [openstack_networking_secgroup_v2.k8s_security_group.name]
  network {
    name = var.network_name
  }
}

# 워커 노드 5대 생성
resource "openstack_compute_instance_v2" "worker_node" {
  count           = 5
  name            = "worker${count.index + 1}"
  flavor_id       = data.openstack_compute_flavor_v2.k8s_node_flavor.id
  image_name      = var.image_name
  key_pair        = openstack_compute_keypair_v2.k8s_keypair.name
  security_groups = [openstack_networking_secgroup_v2.k8s_security_group.name]
  network {
    name = var.network_name
  }
}
