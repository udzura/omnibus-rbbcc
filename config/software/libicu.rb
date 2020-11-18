name "libicu"
default_version "66.1"

source \
  url: "https://github.com/unicode-org/icu/releases/download/release-66-1/icu4c-66_1-src.tgz",
  sha256: "52a3f2209ab95559c1cf0a14f24338001f389615bf00e2585ef3dbc43ecf0a2e"

relative_path "icu/source"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure" \
          " --prefix=#{install_dir}/embedded", env: env
  command "make -j #{workers}", env: env
  command "make -j #{workers} install", env: env
end
