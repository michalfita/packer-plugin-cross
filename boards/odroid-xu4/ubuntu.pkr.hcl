
source "cross" "ubuntu" {
  file_checksum_type    = "md5sum"
  file_checksum_url     = "https://de.eu.odroid.in/ubuntu_24.04lts/XU3_XU4_MC1_HC1_HC2/ubuntu-24.04-6.6-mate-odroid-xu4-20240911.img.xz.md5sum"
  file_target_extension = "xz"
  file_unarchive_cmd    = ["xz", "-d", "$ARCHIVE_PATH"]
  file_urls             = ["https://de.eu.odroid.in/ubuntu_24.04lts/XU3_XU4_MC1_HC1_HC2/ubuntu-24.04-6.6-mate-odroid-xu4-20240911.img.xz"]
  image_build_method    = "reuse"
  image_chroot_env      = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]
  image_partitions {
    filesystem   = "vfat"
    mountpoint   = "/boot"
    name         = "boot"
    size         = "128M"
    start_sector = "2048"
    type         = "c"
  }
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "264192"
    type         = "83"
  }
  image_path                   = "odroid-xu4.img"
  image_size                   = "2G"
  image_type                   = "dos"
  qemu_binary_destination_path = "/usr/bin/qemu-arm-static"
  qemu_binary_source_path      = "/usr/bin/qemu-arm-static"
}

build {
  sources = ["source.cross.ubuntu"]

  provisioner "shell" {
    inline = [
      "touch /home/odroid/test_file"
    ]
  }

}
