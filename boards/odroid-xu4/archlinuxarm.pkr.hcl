
source "cross" "archlinux" {
  file_checksum_type    = "md5"
  file_checksum_url     = "http://hu.mirror.archlinuxarm.org/os/ArchLinuxARM-odroid-xu3-latest.tar.gz.md5"
  file_target_extension = "tar.gz"
  file_unarchive_cmd    = ["bsdtar", "-xpf", "$ARCHIVE_PATH", "-C", "$MOUNTPOINT"]
  file_urls             = ["http://os.archlinuxarm.org/os/ArchLinuxARM-odroid-xu3-latest.tar.gz"]
  image_build_method    = "new"
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "4096"
    type         = "83"
  }
  image_path                   = "odroid-xu4.img"
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
