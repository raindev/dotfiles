name="watchexec"
pkgver="1.24.2"
url="https://github.com/watchexec/watchexec/releases/download/v${pkgver}/watchexec-${pkgver}-x86_64-unknown-linux-gnu.tar.xz"
pkgdesc="Executes commands in response to file modifications"
hash="928d642408c62ad9d955939a5af62b07b7c5210d1c0bf3c974354ec41dc4e3fd"
arch=('amd64')
maintainer="Andrew Barchuk <andrew@raindev.io>"

package() {
  # Binary
  sudo mkdir -p "${pkgdir}/usr/bin"
  sudo mv "./watchexec" "${pkgdir}/usr/bin"
  # Man
  sudo mkdir -p "${pkgdir}/usr/share/man/man1"
  sudo install "./watchexec.1" "${pkgdir}/usr/share/man/man1"
}

# vim:set ft=sh ts=2 sw=2 et:
