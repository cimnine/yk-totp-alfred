#!/bin/bash

source load.sh

echo "Using '${YKTOTP}' as 'yk-totp' command." 1>&2

"${YKTOTP}" yubikey list -fv +P | \
  jq \
    --null-input \
    --raw-input \
    '{
      rerun: 1,
      items:
      [
        inputs
        | split(", ")
        | { id: .[0], version: .[1], type: .[2] }
        | {
            uid: .id,
            title: ( .id + " (" + .type + ", " + .version + ")" ),
            arg: ( env.YKTOTP + " password --device-serial " + .id + " remember" ),
            subtitle: ( env.YKTOTP + " password --device-serial " + .id + " remember" ),
          }
      ]
    }'
