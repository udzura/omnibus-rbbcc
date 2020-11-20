#
# Copyright 2020 YOUR NAME
#
# All Rights Reserved.
#

name "rbbcc"
maintainer "Uchio Kondo"
homepage "https://github.com/udzura/rbbcc"

# Defaults to C:/rbbcc on Windows
# and /opt/rbbcc on all other platforms
install_dir "#{default_root}/#{name}"

# build_version Omnibus::BuildVersion.semver
ENV['VERSION'] ||= "0.6.3"
build_version ENV['VERSION']
build_iteration 1

# Creates required build directories
dependency "preparation"

# override :gcc, version: "9.3.0"
# override :libedit, version: "20191231-3.1"
# override :openssl, version: "1.1.1"
override :rbbcc, version: "default"
dependency "zlib"
dependency "ncurses6"
# dependency "ncurses5"
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

exclude "**/.git"
exclude "**/bundler/git"
