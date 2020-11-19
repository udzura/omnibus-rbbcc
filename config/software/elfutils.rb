name "elfutils"
default_version "0.177"

source \
  url: "https://sourceware.org/ftp/elfutils/#{version}/elfutils-#{version}.tar.bz2",
  sha256: "fa489deccbcae7d8c920f60d85906124c1989c591196d90e0fd668e3dc05042e"

dependency "libbsd"

relative_path "elfutils-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure" \
          " --prefix=#{install_dir}/embedded", env: env
  command "make -j #{workers}", env: env
  command "make -j #{workers} install", env: env
  command "rm -f #{install_dir}/embedded/include/nlist.h", env: env
end
