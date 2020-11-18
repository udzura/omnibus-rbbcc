name "libbsd"
default_version "0.10.0"

source \
  url: "https://libbsd.freedesktop.org/releases/libbsd-0.10.0.tar.xz",
  sha256: "34b8adc726883d0e85b3118fa13605e179a62b31ba51f676136ecb2d0bc1a887"

relative_path "libbsd-0.10.0"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure" \
          " --prefix=#{install_dir}/embedded", env: env
  command "make -j #{workers}", env: env
  command "make -j #{workers} install", env: env
end
