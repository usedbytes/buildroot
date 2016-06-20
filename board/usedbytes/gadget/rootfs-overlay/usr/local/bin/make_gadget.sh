#!/bin/bash
CONFIGFS=/sys/kernel/config/usb_gadget
GADGET=$CONFIGFS/gadget

mkdir $GADGET
echo 0x1209 > $GADGET/idVendor
echo 0x0001 > $GADGET/idProduct

mkdir $GADGET/strings/0x409
echo "00000001" > $GADGET/strings/0x409/serialnumber
echo "usedbytes" > $GADGET/strings/0x409/manufacturer
echo "Gadget" > $GADGET/strings/0x409/product

mkdir $GADGET/configs/c.1
mkdir $GADGET/configs/c.1/strings/0x409
echo "Config 1" > $GADGET/configs/c.1/strings/0x409/configuration
echo 500 > $GADGET/configs/c.1/MaxPower

# Serial port
mkdir $GADGET/functions/acm.usb0
ln -s $GADGET/functions/acm.usb0 $GADGET/configs/c.1

# Ethernet adapter
mkdir $GADGET/functions/rndis.0
echo "02:45:db:1f:2a:11" > $GADGET/functions/rndis.0/host_addr
echo "02:45:db:1f:2a:12" > $GADGET/functions/rndis.0/dev_addr
ln -s $GADGET/functions/rndis.0 $GADGET/configs/c.1

echo 20980000.usb > $GADGET/UDC
