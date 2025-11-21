data "openstack_images_image_v2" "image" {
  name = "lab-rocky-9"
}

data "openstack_compute_flavor_v2" "backend_flavor" {
  name = "m1.medium"
}

resource "openstack_compute_instance_v2" "backend_server" {
  name            = "repository"
  flavor_id       = data.openstack_compute_flavor_v2.backend_flavor.id
  image_id        = data.openstack_images_image_v2.image.id
  key_pair        = "k8s-keypair"
  security_groups = ["lab"]

tags = [
    "repo",
    "minio-version-test",
  ]

  network {
    name = "net-infra"
  }
}
