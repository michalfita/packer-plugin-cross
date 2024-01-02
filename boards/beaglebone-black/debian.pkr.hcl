
source "cross" "debian" {
  file_checksum         = "1d37fb8ef74543dac45c97e32ebb0f79b077ad140dedb9d267456e35f960dd25"
  file_checksum_type    = "sha256"
  file_target_extension = "xz"
  file_unarchive_cmd    = ["xz", "-d", "$ARCHIVE_PATH"]
  file_urls             = ["https://rcn-ee.com/rootfs/bb.org/testing/2022-10-01/buster-iot-armhf/bone-debian-10.13-iot-armhf-2022-10-01-4gb.img.xz"]
  image_build_method    = "reuse"
  image_chroot_env      = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/sbin:/usr/sbin"]
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "8192"
    type         = "83"
  }
  image_path                   = "beaglebone-black.img"
  image_size                   = "4G"
  image_type                   = "dos"
  qemu_binary_destination_path = "/usr/bin/qemu-arm-static"
  qemu_binary_source_path      = "/usr/bin/qemu-arm-static"
}

build {
  sources = ["source.cross.debian"]

  provisioner "shell" {
    inline = [
      "touch /tmp/test"
    ]
  }

}
