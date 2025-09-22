source "cross" "alpine" {
  file_urls             = ["https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/aarch64/alpine-rpi-3.22.1-aarch64.tar.gz"]
  file_checksum_url     = "https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/aarch64/alpine-rpi-3.22.1-aarch64.tar.gz.sha256"
  file_checksum_type    = "sha256"
  file_target_extension = "tar.gz"
  file_unarchive_cmd    = ["bsdtar", "-xpf", "$ARCHIVE_PATH", "-C", "$MOUNTPOINT"]

  image_build_method = "new"
  image_path         = "stage1_picam.img"
  image_size         = "6G"
  image_type         = "dos"
  image_partitions {
    filesystem   = "vfat"
    mountpoint   = "/boot"
    name         = "boot"
    size         = "256M"
    start_sector = "2048"
    type         = "c"
  }
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "526336"
    type         = "83"
  }
  qemu_binary_source_path      = "/usr/bin/qemu-aarch64-static"
  qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
}

build {
  sources = ["source.cross.alpine"]

  provisioner "file" {
    sources = [
      "files/boot/cmdline.txt",
      "files/boot/config.txt",
      "files/boot/start4x.elf",
      "files/boot/fixup4x.dat"
    ]
    destination = "/boot/firmware"
  }
}
