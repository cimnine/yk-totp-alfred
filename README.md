# yk-totp-alfred

This is the repository of an [Alfred][alfred] workflow that allows quickly access your TOTP values of your YubiKey.

It works with multiple connected YubiKeys and it works with password-protected YubiKeys
(as long as you're willing to store the password in your operating system's keyring, e.g. Keychain on macOS).

This workflow is based on [yk-totp][yk-totp].

## Requirements

This workflow requires Python 3, [jq][jq] and a [YubiKey][yubikey].

## Installation

Go [to the releases][release] page and download the `YubiKey TOTP.alfredworkflow` file.

## Usage

Basically you type `yk` into Alfred and choose the respective YubiKey.
It will then generate and list all TOTP codes stored on that YubiKey.
When you select a code, it will copy it to your clipboard.

If a YubiKey does not appear in the list,
it's probably because that YubiKey is password protected.
Type `yk-pwd` into Alfred in this case.
This will give you a list of all password protected YubiKeys discovered on this system.
Select the YubiKey you would like to store the password for and hit enter.
The respective command (to store the password) will be copied to your clipboard and _Terminal.app_ should open (if not, open it yourself).
Now paste the command from the clipboard (`CMD+v`) and hit `Enter`.
You should now be able to enter the password for your YubiKey.
That's it – try typing `yk` into Alfred again and your YubiKey should appear.

[alfred]: https://www.alfredapp.com/
[yubikey]: https://www.yubico.com/products/
[jq]: https://stedolan.github.io/jq
[release]: https://github.com/cimnine/yk-totp-alfred/releases
[yk-totp]: https://github.com/cimnine/yk-totp#readme
