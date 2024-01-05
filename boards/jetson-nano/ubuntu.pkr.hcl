
source "cross" "ubuntu" {
  file_checksum         = "7b87e26d59c560ca18692a1ba282d842"
  file_checksum_type    = "md5"
  file_target_extension = "zip"
  file_urls             = ["https://developer.nvidia.com/jetson-nano-sd-card-image-r3221"]
  image_build_method    = "reuse"
  image_chroot_env      = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "12G"
    start_sector = "24576"
    type         = "83"
  }
  image_path                   = "jetson-nano.img"
  image_size                   = "12G"
  image_type                   = "dos"
  qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
  qemu_binary_source_path      = "/usr/bin/qemu-aarch64-static"
}

build {
  sources = ["source.cross.ubuntu"]

  provisioner "shell" {
    inline = [
      "touch /tmp/test"
    ]
  }

}
