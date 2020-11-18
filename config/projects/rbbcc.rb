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

build_version Omnibus::BuildVersion.semver
build_iteration 1

# Creates required build directories
dependency "preparation"

override :ncurses, version: "6.2"
override :libedit, version: "20191231-3.1"
# override :openssl, version: "1.1.1"
dependency "zlib"
dependency "ncurses"
dependency "ncurses5"
dependency "openssl"
dependency "liblzma"
dependency "libxml2"
dependency "libedit2"
dependency "libbsd"
dependency "libicu"
dependency "python"

dependency "rbbcc"
dependency "ruby"

# rbbcc dependencies/components
# dependency "somedep"

exclude "**/.git"
exclude "**/bundler/git"
