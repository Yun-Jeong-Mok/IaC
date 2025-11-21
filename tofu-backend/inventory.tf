resource "null_resource" "ansible_host_update" {

  triggers = {
    backend_ip = openstack_compute_instance_v2.backend_server.access_ip_v4
  }

  provisioner "local-exec" {
    command = <<EOT
      BACKEND_IP="${self.triggers.backend_ip}"
      HOST_NAME="${openstack_compute_instance_v2.backend_server.name}"
      
      HOSTS_FILE="/root/ansible/hosts" 
      
      
      sed -i "/^$HOST_NAME/d" $HOSTS_FILE 
      
      if ! grep -q "\\[repo\\]" $HOSTS_FILE; then
        echo -e "\n[repo]" >> $HOSTS_FILE
      fi

      echo "$HOST_NAME ansible_host=$BACKEND_IP" >> $HOSTS_FILE
      
      echo "--- Updated Ansible Hosts File ---"
      cat $HOSTS_FILE
    EOT
  }
}
