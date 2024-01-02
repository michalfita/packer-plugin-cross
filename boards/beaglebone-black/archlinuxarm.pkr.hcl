
source "cross" "archlinux" {
  file_checksum_type    = "md5"
  file_checksum_url     = "http://de4.mirror.archlinuxarm.org/os/ArchLinuxARM-am33x-latest.tar.gz.md5"
  file_target_extension = "tar.gz"
  file_unarchive_cmd    = ["bsdtar", "-xpf", "$ARCHIVE_PATH", "-C", "$MOUNTPOINT"]
  file_urls             = ["http://os.archlinuxarm.org/os/ArchLinuxARM-am33x-latest.tar.gz"]
  image_build_method    = "new"
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "2048"
    type         = "83"
  }
  image_path                   = "beaglebone-black.img"
  image_size                   = "2G"
  image_type                   = "dos"
  qemu_binary_destination_path = "/usr/bin/qemu-arm-static"
  qemu_binary_source_path      = "/usr/bin/qemu-arm-static"
}

build {
  sources = ["source.cross.archlinux"]

  provisioner "shell" {
    inline = [
      "pacman-key --init",
      "pacman-key --populate archlinuxarm"
    ]
  }

}
