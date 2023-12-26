name="watchexec"
pkgdesc="Executes commands in response to file modifications"
maintainer="Andrew Barchuk <andrew@raindev.io>"
pkgver="1.24.2"
arch=('amd64' 'arm64')
if [[ ${CARCH} == amd64 ]]; then
    hash="928d642408c62ad9d955939a5af62b07b7c5210d1c0bf3c974354ec41dc4e3fd"
    arch_prefix="x86_64"
else
    hash="67e2d7626231d1123ace6cb386af816d132858746dbd465aef1fca210b88785c"
    arch_prefix="aarch64"
fi
url="https://github.com/watchexec/watchexec/releases/download/v${pkgver}/watchexec-${pkgver}-${arch_prefix}-unknown-linux-gnu.tar.xz"

package() {
  # Binary
  sudo mkdir -p "${pkgdir}/usr/bin"
  sudo mv "./watchexec" "${pkgdir}/usr/bin"
  # Man
  sudo mkdir -p "${pkgdir}/usr/share/man/man1"
  sudo install "./watchexec.1" "${pkgdir}/usr/share/man/man1"
}

# vim:set ft=sh ts=2 sw=2 et:
