class X3270 < Formula
  desc "IBM 3270 terminal emulator for the X Window System and Windows"
  homepage "http://x3270.bgp.nu/"
  url "https://downloads.sourceforge.net/project/x3270/x3270/3.5ga8/suite3270-3.5ga8-src.tgz"
  sha256 "04d98c2644d8acc3b0089f85558074623500bc194c41609298b344b6e5d905d2"

  bottle do
    sha256 "98fb8fcfa643ebe4fea34b8dfa274cce932fddc57278db70965c87b6ad24b12a" => :sierra
    sha256 "27838aba0027f840ae36745ddd3408af319e08ddf9bda054ad4c9a90821d091c" => :el_capitan
    sha256 "9aace6f65ca096ecd6153a46351eef9c985791f3118ae9719d3da11c9c251bfa" => :yosemite
  end

  option "with-c3270", "Include c3270 (curses-based version)"
  option "with-s3270", "Include s3270 (displayless version)"
  option "with-tcl3270", "Include tcl3270 (integrated with Tcl)"
  option "with-pr3287", "Include pr3287 (printer emulation)"

  depends_on :x11
  depends_on "openssl"

  def install
    args = ["--prefix=#{prefix}"]
    args << "--enable-x3270"
    args << "--enable-c3270" if build.with? "c3270"
    args << "--enable-s3270" if build.with? "s3270"
    args << "--enable-tcl3270" if build.with? "tcl3270"
    args << "--enable-pr3287" if build.with? "pr3287"

    system "./configure", *args
    system "make", "install"
    system "make", "install.man"
  end

  test do
    system bin/"x3270", "--version"
  end
end
