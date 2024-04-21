#!/bin/sh
set -e

export MESA_LOADER_DRIVER_OVERRIDE=asahi
export XDG_RUNTIME_DIR=/run/user/1000

exec sommelier --virtgpu-channel -X --glamor bash "$@"
