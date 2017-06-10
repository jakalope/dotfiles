#!/usr/bin/env bash

service lightdm stop
echo 'blacklist nouveau' >> /etc/modprobe.d/blacklist-nouveau.conf
update-initramfs -u
sh cuda_8.0.61_375.26_linux.run --override
service lightdm start
nvcc --version
nvidia-smi

