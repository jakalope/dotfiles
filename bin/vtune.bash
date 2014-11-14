#!/bin/bash

sudo bash -c 'echo 0 > /proc/sys/kernel/nmi_watchdog'
sudo bash -c 'echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope'
/opt/intel/vtune_amplifier_xe/bin64/amplxe-gui
