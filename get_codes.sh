#!/bin/bash

source load.sh

if [ "${serial}x" != "x" ]; then
  filter="${1}"
else
  serial="${1}"
  filter="${2}"
fi

"${YKTOTP}" totp -d "${serial}" codes +i "${filter}" | \
  jq \
    --null-input \
    --raw-input \
    '{
      rerun: 5,
      items:
      [
        inputs
        | split(": ")
        | {
            cred: (
                    .[0] |
                    split(":") |
                    {
                      issuer: .[0],
                      user: .[1]
                    }
                  ),
            code: .[1]
          }
        | {
            uid: ( .cred.issuer + ":" + .cred.user ),
            arg: .code,
            title: .code,
            match: ( .cred.issuer + " " + .cred.user ),
            subtitle: ( .cred.issuer + " (" + .cred.user + ")" )
          }
      ]
    }'




