#
# Copyright 2020 Uchio Kondo
#

name "allbcc"
maintainer "Uchio Kondo"
homepage "https://github.com/udzura/rbbcc"

install_dir "#{default_root}/#{name}"

# build_version Omnibus::BuildVersion.semver
ENV['VERSION'] ||= "0.6.4"
codename = `lsb_release -c`.chomp.split[-1]
build_version [ENV['VERSION'], codename].join("-")
build_iteration 1

# Creates required build directories
dependency "preparation"

# override :gcc, version: "9.3.0"
# override :libedit, version: "20191231-3.1"
override :openssl, version: "1.1.1d"
override :bcc, version: "0.16.0-all"
override :rbbcc, version: "default"
dependency "libbz2" # when bionic...
dependency "zlib"
# dependency "ncurses6"
dependency "ncurses5" # when bionic...
dependency "openssl"
# dependency "gcc" # FIXME: libgcc_s.so is needed but long long build
dependency "liblzma"
# dependency "libxml2"
# dependency "libedit2"
# dependency "libbsd"
# dependency "libicu"
# dependency "python"
# dependency "llvm-clang"
dependency "elfutils"

dependency "bcc"
dependency "ruby"
dependency "rbbcc"

dependency "gem-permissions"
dependency "shebang-cleanup"
dependency "ruby-cleanup"
dependency "clean-archives"

exclude "**/.git"
exclude "**/bundler/git"
