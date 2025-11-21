locals {
  control_host_lines = [
    for i in range(3) :
    "${openstack_compute_instance_v2.control_plane[i].network[0].fixed_ip_v4} control${i + 1}"
  ]
  worker_host_lines = [
    for i in range(5) :
    "${openstack_compute_instance_v2.worker_node[i].network[0].fixed_ip_v4} worker${i + 1}"
  ]
  
  k8s_nodes_hosts = join("\n", concat(local.control_host_lines, local.worker_host_lines))
  
  haproxy_host = "${openstack_compute_instance_v2.haproxy_server.network[0].fixed_ip_v4} haproxy"
}


resource "null_resource" "update_hosts_file" {
  depends_on = [
    openstack_compute_instance_v2.haproxy_server,
    openstack_compute_instance_v2.control_plane,
    openstack_compute_instance_v2.worker_node,
  ]

  provisioner "local-exec" {
    command = <<-EOT
      HOSTS_FILE=/etc/hosts
      
      sed -i '/# K8S NODES START/,/# K8S NODES END/d' $HOSTS_FILE
      
      HOSTS_ENTRY="${local.haproxy_host}\n${local.k8s_nodes_hosts}"
      
      echo "" >> $HOSTS_FILE
      echo "# K8S NODES START" >> $HOSTS_FILE
      echo "$HOSTS_ENTRY" >> $HOSTS_FILE
      echo "# K8S NODES END" >> $HOSTS_FILE
    EOT
  }
}
