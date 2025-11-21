resource "local_file" "ansible_inventory" {
  filename = "../ansible/hosts" 
  content = templatefile("${path.module}/inventory.tpl", {
    haproxy_ip    = openstack_compute_instance_v2.haproxy_server.network[0].fixed_ip_v4
    control_ips   = openstack_compute_instance_v2.control_plane[*].network[0].fixed_ip_v4 
    worker_ips    = openstack_compute_instance_v2.worker_node[*].network[0].fixed_ip_v4
    
    all_nodes_ips = concat(
        openstack_compute_instance_v2.control_plane[*].network[0].fixed_ip_v4,
        openstack_compute_instance_v2.worker_node[*].network[0].fixed_ip_v4,
    )
  })
}
