output "backend_ip_address" {
  description = "The internal IP address of the K8s Backend (MinIO/Gitea) server"
  value       = openstack_compute_instance_v2.backend_server.access_ip_v4
}
