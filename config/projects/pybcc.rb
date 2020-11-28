#
# Copyright 2020 Uchio Kondo
#

name "pybcc"
maintainer "Uchio Kondo"
homepage "https://github.com/udzura/omnibus-rbbcc"

# /opt/bcc on all other platforms
install_dir "#{default_root}/bcc"

# build_version Omnibus::BuildVersion.semver
ENV['VERSION'] ||= "0.16.0"
codename = `lsb_release -c`.chomp.split[-1]
build_version [ENV['VERSION'], codename].join("-")
build_iteration 1

# Creates required build directories
dependency "preparation"

# override :gcc, version: "9.3.0"
# override :libedit, version: "20191231-3.1"
# override :openssl, version: "1.1.1"
override :bcc, version: "0.16.0-all"
dependency "libbz2" # when bionic...
dependency "zlib"

if codename == 'focal' # This is for llvm 10
  overwrite :ncurses5, version: "6.2"
end
dependency "ncurses5"

dependency "openssl"
# dependency "gcc" # FIXME: libgcc_s.so is needed but long long build
dependency "liblzma"
dependency "elfutils"

dependency "bcc"

dependency "clean-archives"

exclude "**/.git"
exclude "**/bundler/git"
