#
# Copyright 2012-2019, Chef Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "ncurses6"
default_version "6.2"

license "MIT"
license_file "http://invisible-island.net/ncurses/ncurses-license.html"
license_file "http://invisible-island.net/ncurses/ncurses.faq.html"
skip_transitive_dependency_licensing true

dependency "config_guess"

version("6.2") { source md5: "e812da327b1c2214ac1aed440ea3ae8d", url: "https://ftp.gnu.org/gnu/ncurses/ncurses-6.2.tar.gz" }

relative_path "ncurses-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  env.delete("CPPFLAGS")

  update_config_guess

  configure_command = [
    "./configure",
    "--prefix=#{install_dir}/embedded",
    "--enable-overwrite",
    "--with-shared",
    "--with-termlib",
    "--without-ada",
    "--without-cxx-binding",
    "--without-debug",
    "--without-manpages",
  ]

  command configure_command.join(" "), env: env

  # unfortunately, libtool may try to link to libtinfo
  # before it has been assembled; so we have to build in serial
  make "libs", env: env if aix?

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env

  # Build non-wide-character libraries
  make "distclean", env: env
  configure_command << "--enable-widec"

  command configure_command.join(" "), env: env
  make "libs", env: env if aix?
  make "-j #{workers}", env: env

  # Installing the non-wide libraries will also install the non-wide
  # binaries, which doesn't happen to be a problem since we don't
  # utilize the ncurses binaries in private-chef (or oss chef)
  make "-j #{workers} install", env: env
end
