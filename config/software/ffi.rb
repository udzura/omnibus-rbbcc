#
# Copyright:: Chef Software, Inc.
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

name "ffi"

default_version "3.3"

license "MIT"
license_file "LICENSE"
skip_transitive_dependency_licensing true

version("3.3") { source sha256: "72fba7922703ddfa7a028d513ac15a85c8d54c8d67f55fa5a4802885dc652056" }

source url: "https://sourceware.org/pub/libffi/libffi-#{version}.tar.gz"

relative_path "libffi-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  env["INSTALL"] = "/opt/freeware/bin/install" if aix?

  # disable option checking as disable-docs is 3.3+ only
  configure_command = ["--disable-option-checking",
                       "--disable-docs",
  ]

  # AIX's old version of patch doesn't like the patch here
  unless aix?
    # disable multi-os-directory via configure flag (don't use /lib64)
    # Works on all platforms, and is compatible on 32bit platforms as well
    configure_command << "--disable-multi-os-directory"
  end

  configure(*configure_command, env: env)

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env

  # libffi's default install location of header files is awful...
  mkdir "#{install_dir}/embedded/include"
  copy "#{install_dir}/embedded/lib/libffi-#{version}/include/*", "#{install_dir}/embedded/include/"
end
