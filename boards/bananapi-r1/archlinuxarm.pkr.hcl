
source "cross" "archlinux" {
  file_checksum_type    = "md5"
  file_checksum_url     = "http://mkaczanowski.com/files/archlinux-bpi-r1-2017-28-2017-4.6.5-sunxi-mainline.img.gz.md5"
  file_target_extension = "gz"
  file_unarchive_cmd    = ["gunzip", "$ARCHIVE_PATH"]
  file_urls             = ["http://mkaczanowski.com/files/archlinux-bpi-r1-2017-28-2017-4.6.5-sunxi-mainline.img.gz"]
  image_build_method    = "reuse"
  image_partitions {
    filesystem   = "vfat"
    mountpoint   = "/boot"
    name         = "boot"
    size         = "56M"
    start_sector = "8192"
    type         = "c"
  }
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "3.7G"
    start_sector = "122880"
    type         = "83"
  }
  image_path                   = "bananapi-r1.img"
  image_size                   = "4G"
  image_type                   = "dos"
  qemu_binary_destination_path = "/usr/bin/qemu-arm-static"
  qemu_binary_source_path      = "/usr/bin/qemu-arm-static"
}

build {
  sources = ["source.cross.archlinux"]

  provisioner "shell" {
    inline = [
      "touch /tmp/test"
    ]
  }

}
