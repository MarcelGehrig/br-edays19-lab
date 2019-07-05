

Getting Buildroot
wget https://www.buildroot.org/downloads/buildroot-2019.05.tar.bz2

Unpack with
tar xjvf Downloads/buildroot-2019.05.tar.bz2



git commit -m "2019.07.03 initial import"
git push -u origin master

git tag -a init -m "2019.07.03 initial import"
git push origin --tags





LAB1

cd buildroot-2019.05/
make qemu_arm_versatile_defconfig

make linux-menuconfig




[*] Networking support  ---> 
    Networking options  --->
      [*]   IP: kernel level autoconfiguration  
      [*]     IP: DHCP support
      [*]     IP: BOOTP support
      [*]     IP: RARP support 


File systems  --->
[*] Network File Systems  ---> 
--- Network File Systems
<*>   NFS client support 
<*>     NFS client support for NFS version 2 (NEW)    
<*>     NFS client support for NFS version 3 (NEW) 
[ ]       NFS client support for the NFSv3 ACL protocol extension (NEW) 
<*>     NFS client support for NFS version 4                      
[ ]     Provide swap over NFS support (NEW)   
[ ]   NFS client support for NFSv4.1 (NEW) 
[*]   Root file system on NFS 


make linux-update-defconfig




qemu-system-arm \
  -M versatilepb \
  -kernel output/images/zImage \
  -dtb output/images/versatile-pb.dtb \
  -drive file=output/images/rootfs.ext2,if=scsi,format=raw \
  -append "root=/dev/sda console=ttyAMA0,115200" \
  -serial stdio \
  -net nic,model=rtl8139 -net user \
  -redir tcp:2222::22 \
  -name Versatile_ARM_EXT2


git tag -a lab1_start -m "2019.07.03 ready for LAB1"
git push origin --tags


Aufgabe
- Definieren des Rootpassworted noser

    System configuration  --->
(noser) Root password       

- hinzufügen des Packetes Dropbear

 Target packages  --->
    Networking applications  --->        
      [*] dropbear
      [*]   client programs (NEW)
      [ ]   disable reverse DNS lookups (NEW)
      [*]   optimize for size (NEW)
      [ ]   log dropbear access to wtmp (NEW)
      [ ]   log dropbear access to lastlog (NEW)
      [ ]   enable legacy crypto (NEW) 


- ändern des root filesystems auf ext4

    Filesystem images  ---> 
[*] ext2/3/4 root filesystem
      ext2/3/4 variant (ext4)  --->


make menuconfig


make

qemu-system-arm \
  -M versatilepb \
  -kernel output/images/zImage \
  -dtb output/images/versatile-pb.dtb \
  -drive file=output/images/rootfs.ext4,if=scsi,format=raw \
  -append "root=/dev/sda console=ttyAMA0,115200" \
  -serial stdio \
  -net nic,model=rtl8139 -net user \
  -redir tcp:2222::22 \
  -name Versatile_ARM_EXT2




 ssh -p2222 root@127.0.0.1




Absteichern neue default config 

make update-defconfig


git commit -m "end of LAB1"

git tag -a lab1_end -m "2019.07.03 end of LAB1"
git push origin --tags



git tag -a lab2_start -m "2019.07.04 ready for LAB2"
git push origin --tags

git tag -a lab2_end -m "2019.07.04 end of LAB2"
git push origin --tags


git tag -a lab3_start -m "2019.07.04 ready for LAB3"
git push origin --tags


package/hello-noser

package/hello-noser/hello-noser.cpp
#include <iostream>

int main()
{
    std::cout << "Hello Noser!\n";
    return 0;
}

package/hello-noser/CMakeLists.txt

cmake_minimum_required(VERSION 2.4)

project(hello_noser)

add_executable(hello-noser.cpp)


package/Config.in:

menu "Noser E-Days"
    source "package/tftpd/Config.in"
	source "package/hello-noser/Config.in"
endmenu


package/hello-noser/Config.in:

config BR2_PACKAGE_HELLO_NOSER
    bool "hello_noser"
    help
        Hello Noser package.

        http://www.noser.com



package/hello/hello-noser.mk:


################################################################################
#
# hello
#
################################################################################

HELLO_VERSION = 1.0
HELLO_SITE = ./package/hello/src
HELLO_SITE_METHOD = local

define HELLO_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)
endef

define HELLO_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/hello $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))





make hello-noser-dirclean && make hello-noser

qemu-system-arm \
  -M versatilepb \
  -kernel output/images/zImage \
  -dtb output/images/versatile-pb.dtb \
  -drive file=output/images/rootfs.ext4,if=scsi,format=raw \
  -append "root=/dev/sda console=ttyAMA0,115200" \
  -serial stdio \
  -net nic,model=rtl8139 -net user \
  -redir tcp:2222::22 \
  -redir udp:2223::69 \
  -name Versatile_ARM_EXT2

# hello-noser 
Hello Noser :-)
# 

hello-noser.mk


git tag -a lab4_start -m "2019.07.04 ready for LAB4"
git push origin --tags


git tag -a -f lab4_start d30f789
git push --tags --force

make BR2_EXTERNAL=../noser-external menuconfig

make BR2_EXTERNAL=../noser-external hello-noser-dirclean

make BR2_EXTERNAL=/work/br-edays19-lab/noser-external hello-noser



https://gist.github.com/sbourdelin/9668e8d3071cdbc4f81c


make BR2_EXTERNAL=../noser-external noser_defconfig
make BR2_EXTERNAL=../noser-external menuconfig


├── board
│   └── noser
│       └── qemu_arm_versatile
│           ├── patches
│           └── rootfs_overlay
│               └── etc
├── Config.in
├── configs
│   └── noser_defconfig
├── external.desc
├── external.mk
├── package
│   ├── hello-noser
│   │   ├── Config.in
│   │   ├── hello-noser.mk
│   │   └── src
│   │       ├── CMakeLists.txt
│   │       └── hello-noser.c
│   └── hello-noser2
│       ├── Config.in
│       ├── hello-noser2.mk
│       └── src
│           ├── hello-noser2.c
│           └── Makefile
└── patches
    └── libunwind
        └── 0001-libunwind-fPIC.patch

14 directories, 13 files

make BR2_EXTERNAL=../noser-external update-defconfig



git tag -a lab4_end -m "2019.07.05 end of LAB4"
git push origin --tags





