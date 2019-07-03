

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







