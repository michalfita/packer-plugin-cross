
source "cross" "archlinux" {
  file_checksum_type    = "md5"
  file_checksum_url     = "http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-armv7-latest.tar.gz.md5"
  file_target_extension = "tar.gz"
  file_unarchive_cmd    = ["bsdtar", "-xpf", "$ARCHIVE_PATH", "-C", "$MOUNTPOINT"]
  file_urls             = ["http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-armv7-latest.tar.gz"]
  image_build_method    = "new"
  image_partitions {
    filesystem   = "vfat"
    mountpoint   = "/boot-tmp"
    name         = "boot"
    size         = "256M"
    start_sector = "8192"
    type         = "c"
  }
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "532480"
    type         = "83"
  }
  image_path                   = "raspberry-pi.img"
  image_size                   = "2G"
  image_type                   = "dos"
  qemu_binary_destination_path = "/usr/bin/qemu-arm-static"
  qemu_binary_source_path      = "/usr/bin/qemu-arm-static"
}

build {
  sources = ["source.cross.archlinux"]

  provisioner "shell" {
    inline = [
      "mv boot/* boot-tmp/",
      "mount --bind boot-tmp boot",
      "pacman-key --init",
      "pacman-key --populate archlinuxarm",
      "mv /etc/resolv.conf /etc/resolv.conf.bk",
      "echo 'nameserver 8.8.8.8' > /etc/resolv.conf",
      "pacman -Sy --noconfirm --needed",
      "pacman -S parted --noconfirm --needed",
      "umount boot"
    ]
  }

  provisioner "file" {
    destination = "/tmp"
    source      = "scripts/resizerootfs"
  }

  provisioner "shell" {
    script = "scripts/bootstrap_resizerootfs.sh"
  }

}
