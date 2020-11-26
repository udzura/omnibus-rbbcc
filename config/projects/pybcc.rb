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
build_version ENV['VERSION']
build_iteration 1

# Creates required build directories
dependency "preparation"

# override :gcc, version: "9.3.0"
# override :libedit, version: "20191231-3.1"
# override :openssl, version: "1.1.1"
override :bcc, version: "0.16.0-all"
dependency "libbz2" # when bionic...
dependency "zlib"
# dependency "ncurses6"
dependency "ncurses5" # when bionic...
dependency "openssl"
# dependency "gcc" # FIXME: libgcc_s.so is needed but long long build
dependency "liblzma"
dependency "elfutils"

dependency "bcc"

exclude "**/.git"
exclude "**/bundler/git"
