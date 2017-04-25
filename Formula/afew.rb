class Afew < Formula
  include Language::Python::Virtualenv
  desc "Initial tagging script for notmuch mail"
  homepage "https://github.com/afewmail/afew"
  url "https://github.com/afewmail/afew/archive/1.0.0.tar.gz"
  sha256 "827b1edfaeb39bcaaca9aca839b5a3d1b2fab350c7d1f8b1b097b35f2d816746"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "notmuch"
  depends_on "sphinx-doc" => :build

  resource "subprocess32" do
    url "https://pypi.python.org/packages/be/f4/c8a56bf66e4d656e95e90115db9bf076fddb9cf2d138860b5b8265c90d3c/subprocess32-3.2.7.zip"
    sha256 "7e787be117aa7db8fd856998cf27ebafb3fcf3919eee4981d9edb5d22dd2d052"
  end

  resource "chardet" do
    url "https://pypi.python.org/packages/91/05/28f23094cdf1410fb03533f0d71e6b4aad3c504100e83b8cea6fc899552c/chardet-3.0.2.tar.gz"
    sha256 "4f7832e7c583348a9eddd927ee8514b3bf717c061f57b21dbe7697211454d9bb"
  end

  def install
    virtualenv_install_with_resources

    system "make", "-C", "docs", "html"
    doc.install Dir["docs/build/html/*"]

    system "make", "-C", "docs", "man"
    man1.install Dir["docs/build/man/*.1"]
  end

  test do
    system "#{bin}/afew", "--help"
  end
end
