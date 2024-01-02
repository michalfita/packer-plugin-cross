
source "cross" "archlinux" {
  file_checksum_type    = "md5"
  file_checksum_url     = "http://hu.mirror.archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz.md5"
  file_target_extension = "tar.gz"
  file_unarchive_cmd    = ["bsdtar", "-xpf", "$ARCHIVE_PATH", "-C", "$MOUNTPOINT"]
  file_urls             = ["http://hu.mirror.archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz"]
  image_build_method    = "new"
  image_partitions {
    filesystem   = "fat"
    mountpoint   = "/boot-tmp"
    name         = "boot"
    size         = "400M"
    start_sector = "2048"
    type         = "b"
  }
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "821248"
    type         = "83"
  }
  image_path                   = "parallella.img"
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
      "rm -f /etc/resolv.conf",
      "echo 'nameserver 8.8.8.8' > /etc/resolv.conf",
      "echo '\n[mkaczanowski]\nServer = https://raw.githubusercontent.com/mkaczanowski/pkgbuilds/master/pkg/$arch\nSigLevel = PackageOptional' >> /etc/pacman.conf",
      "pacman -R linux-armv7 --noconfirm",
      "pacman -Sy linux-parallella --noconfirm",
      "pacman -S parallella-fpga-bitstream-headless-7010 --noconfirm",
      "echo 'pacman -Sy paralella-examples epiphany-sdk' > /home/alarm/other_packages",
      "umount boot"
    ]
  }

}
