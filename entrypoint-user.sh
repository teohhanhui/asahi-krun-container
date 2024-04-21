#!/bin/sh
set -e

export MESA_LOADER_DRIVER_OVERRIDE=asahi
export XDG_RUNTIME_DIR=/run/user/1000

mkdir -p ${XDG_RUNTIME_DIR}/pulse
rm -f ${XDG_RUNTIME_DIR}/pulse/pid
pulseaudio -D --exit-idle-time=-1

exec sommelier --virtgpu-channel -X --glamor "$@"
