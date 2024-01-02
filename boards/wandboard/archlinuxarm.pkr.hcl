
source "cross" "archlinux" {
  file_checksum_type    = "md5"
  file_checksum_url     = "http://os.archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz.md5"
  file_target_extension = "tar.gz"
  file_unarchive_cmd    = ["bsdtar", "-xpf", "$ARCHIVE_PATH", "-C", "$MOUNTPOINT"]
  file_urls             = ["http://os.archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz"]
  image_build_method    = "new"
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "8192"
    type         = "83"
  }
  image_path                   = "wandboard.img"
  image_setup_extra            = [["wget", "http://os.archlinuxarm.org/os/imx6/boot/wandboard/boot.scr", "-O", "$MOUNTPOINT/boot/boot.scr"]]
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
      "pacman-key --populate archlinuxarm",
      "rm -f /etc/resolv.conf",
      "echo 'nameserver 8.8.8.8' > /etc/resolv.conf",
      "rm /boot/boot.scr",
      "yes | pacman -Sy uboot-wandboard"
    ]
  }

}
