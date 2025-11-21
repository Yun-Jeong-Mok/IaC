# HAProxy 서버의 내부 IP 주소
output "haproxy_internal_ip" {
  description = "HAProxy Server의 내부(Fixed) IP 주소"
  value       = openstack_compute_instance_v2.haproxy_server.network[0].fixed_ip_v4
}

# 컨트롤 노드들의 내부 IP 주소 목록
output "control_plane_ips" {
  description = "컨트롤 노드들의 내부 IP 주소 목록"
  value       = [for instance in openstack_compute_instance_v2.control_plane : instance.network[0].fixed_ip_v4]
}

# 워커 노드들의 내부 IP 주소 목록
output "worker_node_ips" {
  description = "워커 노드들의 내부 IP 주소 목록"
  value       = [for instance in openstack_compute_instance_v2.worker_node : instance.network[0].fixed_ip_v4]
}

# 모든 노드들의 내부 IP 주소 목록 (Ansible hosts 그룹 정의용)
output "all_nodes_ips" {
  description = "모든 K8s 노드들의 내부 IP 주소 목록"
  value = concat(
    [for instance in openstack_compute_instance_v2.control_plane : instance.network[0].fixed_ip_v4],
    [for instance in openstack_compute_instance_v2.worker_node : instance.network[0].fixed_ip_v4],
  )
}
