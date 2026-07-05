# driver
px-x1ud driver installation script.

## Driver Installation
```bash
$ cd driver
$ ./driver-install.sh
```

## system reboot
```bash
$ sudo reboot
```

## Driver confirmation after system reboot
```bash
$ lsmod | grep smsusb
smsusb                 28672  0
smsmdtv                77824  2 smsusb,smsdvb
mc                     77824  3 smsusb,smsdvb,dvb_core

$ ls -R /dev/dvb/
/dev/dvb/:
adapter0  adapter1

/dev/dvb/adapter0:
demux0	dvr0  frontend0
```

## B-CAS card read soft install
```bash
$ sudo apt install -y libpcsclite-dev libccid pcscd pcsc-tools
$ pcsc_scan
```
