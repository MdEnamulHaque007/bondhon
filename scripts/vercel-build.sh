#!/usr/bin/env bash
set -euo pipefail

flutter_root="/tmp/bondhon-flutter"

if [[ ! -x "$flutter_root/bin/flutter" ]]; then
  git clone --depth 1 --branch stable \
    https://github.com/flutter/flutter.git "$flutter_root"
fi

"$flutter_root/bin/flutter" config --enable-web
"$flutter_root/bin/flutter" pub get
"$flutter_root/bin/flutter" build web --release
