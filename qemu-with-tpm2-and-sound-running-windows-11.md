# DRAFT and incomplete, use at own risk

Qemu, Running Windows 11 --with sound-- on a i7 4th generation cpu

I was eager to try Windows 11 on my laptop but was set aback when I learned that you needed “almost new” hardware for it to work. TPM2 did not discourage me as I quickly found out you could use a Software TPM with Qemu but the compatible cpu list excluded the CPU I had in my old DELL XPS 15 9530 laptop.

Out of the box, I could not emulate any recent i7 deemed recent enough for the HealthCheck application to want to upgrade to Windows 11 with the Insider Program. Until it finally clicked that maybe a Xeon might do the trick. Which it did. The key to getting all this to work is the -cpu Skylake-Server-v3 parameter
Ingredients

    DELL XPS 15 9530
    i7 4th generation
    16 GB Ram
    Linux Ubuntu
    Qemu
    Qemu scsi virtio drivers - https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
    libtpms - https://github.com/stefanberger/libtpms
    swtpm - https://github.com/stefanberger/swtpm
    Spice protocol binaries - https://www.spice-space.org/download.html
    Windows 10 and its product key
    Internet connection

Recipe

    Build/Install libtpms
    Build/Install swtpm
    Install Qemu
    Download virtio iso
    Create hard drive for windows 10 installation

$ qemu-img create -f qcow2 win11-cdrive.qcow2 256G

Create your swtpm space

$ mkdir /tmp/emulated_tpm

$ swtpm socket --tpmstate dir=/tmp/emulated_tpm --ctrl type=unixio,path=/tmp/emulated_tpm/swtpm-sock --log level=20 --tpm2

    Launch Qemu and emulate an Intel Xeon cpu with a minimum of 2 cores and 4GB of RAM (make sure you have other parameters for scsi and uefi boot)

Note: I made a .sh file which I launch like below:

mkdir /tmp/second_emulated_tpm
swtpm socket --tpmstate dir=/tmp/second_emulated_tpm --ctrl type=unixio,path=/tmp/second_emulated_tpm/swtpm-sock --log level=20 --tpm2 &

QEMU_AUDIO_DRV=spice 
qemu-system-x86_64 \
-enable-kvm \
-k en-us \
-m 4096 \
-machine pc-q35-4.2,accel=kvm,usb=off,vmport=off,dump-guest-core=off \
-cpu Skylake-Server-v3,vme=on,ss=on,vmx=on,pdcm=on,f16c=on,rdrand=on,hypervisor=on,arat=on,tsc-adjust=on,umip=on,md-clear=on,stibp=on,arch-capabilities=on,ssbd=on,xsaveopt=on,pdpe1gb=on,abm=on,ibpb=on,ibrs=on,amd-stibp=on,amd-ssbd=on,skip-l1dfl-vmentry=on,pschange-mc-no=on,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff \
-smp cores=2 \
-rtc base=localtime,clock=vm \
-device virtio-scsi-pci,id=scsi \
-device scsi-hd,drive=hd \
-drive if=none,id=hd,file=./cdrive-win11.qcow2,format=qcow2 \
-drive file=/home/martin/Downloads/wintv.iso,media=cdrom,readonly=on \
-drive if=pflash,format=raw,readonly,file=./OVMF_CODE.fd \
-drive if=pflash,format=raw,file=./OVMF_VARS.fd \
-boot menu=on \
-chardev socket,id=chrtpm,path=/tmp/second_emulated_tpm/swtpm-sock \
-tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0 \
-device usb-ehci,id=ehci -device usb-host,bus=ehci.0,port=1,vendorid=0x05ac,id=ipad \
-device qemu-xhci,id=xhci -device usb-tablet \
-gdb tcp::1234 \
-netdev user,id=user.0 -device e1000,netdev=user.0 \
-no-hpet \
-global ICH9-LPC.disable_s3=1 \
-global ICH9-LPC.disable_s4=1 \
-boot strict=on \
-device ich9-intel-hda,id=sound0,bus=pcie.0,addr=0x1b \
-device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 \
-device qxl-vga 


# https://github.com/qemu/qemu/blob/master/docs/system/devices/usb.rst
# Supposing that devices plugged into a given physical port appear as bus 1 + port 1 for 2.0 devices and bus 3 + port 1 for 1.1 devices, 
# you can pass through any device plugged into that port and also assign it to the correct USB bus in QEMU like this:
#|qemu_system| -M pc [...]                            \
#     -usb                                                 \
#     -device usb-ehci,id=ehci                             \
#     -device usb-host,bus=usb-bus.0,hostbus=3,hostport=1  \
#     -device usb-host,bus=ehci.0,hostbus=1,hostport=1

