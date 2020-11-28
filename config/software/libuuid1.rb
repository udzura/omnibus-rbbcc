name "libuuid1"
default_version "2.31.1"

license "LGPL-2.1"
license_file "COPYING"

source url: "https://www.kernel.org/pub/linux/utils/util-linux/v#{version}/util-linux-#{version}.tar.gz"

# We use the version in util-linux, and only build the libuuid subdirectory
version "2.31.1" do
  source sha256: "d636cb23a2a4aaeeec4b1b52c702366a83978f5a3aaf3029431e7a76a7095323",
         url: "https://www.kernel.org/pub/linux/utils/util-linux/v2.31/util-linux-2.31.1.tar.gz"
end
version "2.21" do
  source md5: "4222aa8c2a1b78889e959a4722f1881a"
end

relative_path "util-linux-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure --prefix=#{install_dir}/embedded --enable-shared --disable-all-programs --enable-libuuid", env: env

  make "-j #{workers} ", env: env
  make "-j #{workers} install || true", env: env
end
