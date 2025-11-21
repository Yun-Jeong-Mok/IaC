# Opentofu와 Ansible로 쿠버네티스 클러스터 구성

| 구성 - 컨트롤 3대 워커 5대 로드밸런서(HAproxy) 1대 토푸 백엔드(minIO) 1대 총 10대

클라우드 플랫폼 - Openstack
OS - Rocky9

쿠버네티스 및 런타임(CRI-O) 버전 - v1.32.9

토푸 버전

```
OpenTofu v1.10.7
on linux_amd64
```

앤서블 버전

```
ansible [core 2.14.18]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.9/site-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.9.21 (main, Feb 10 2025, 00:00:00) [GCC 11.5.0 20240719 (Red Hat 11.5.0-5)] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
```

---
### 디렉터리 역할
- ansible - 쿠버네티스 클러스터를 HAproxy 1대와 8대로 HA 구성
- opentofu - 오픈스택 상에서 VM들을 프로비저닝
- tofu-backend - 백엔드로 지정할 VM 생성해서 이후 podman에 오브젝트 스토리지 minIO 컨테이너 띄우고 연결


오픈토푸로 키페어 생성 및 할당, 보안그룹 설정 및 할당, 네트워크 할당 등...
이후 앤서블로 쿠버네티스 클러스터 구성

10대 중 로드밸런서와 k8s 제외 1대는 저장소 용도로 gitea와 minIO 구축해 코드와 토푸 상태를 저장하는 버전 관리 노드로 사용
