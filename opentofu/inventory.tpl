[all:vars]
ansible_user=rocky 
ansible_ssh_private_key_file=/root/.ssh/id_ed25519_k8s
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[k8s_cluster:children]
control
worker
haproxy

[haproxy]
proxy ansible_host=${haproxy_ip}

[control]
%{ for ip in control_ips ~}
control${index(control_ips, ip) + 1} ansible_host=${ip}
%{ endfor ~}

[worker]
%{ for ip in worker_ips ~}
worker${index(worker_ips, ip) + 1} ansible_host=${ip}
%{ endfor ~}
