name "bcc"
default_version "0.16.0"

dependency "elfutils"

license "Apache-2.0"
license_file "LICENSE.txt"
skip_transitive_dependency_licensing true

version("0.16.0") {
  source url: "https://github.com/iovisor/bcc/releases/download/v#{version}/bcc-src-with-submodule.tar.gz",
         sha256: "7a4551cae82964e5359ebd0df645824a82539ad0f6a86b27fc399680aed767f7"
}

version("0.16.0-all") {
  source url: "https://github.com/iovisor/bcc/releases/download/v0.16.0/bcc-src-with-submodule.tar.gz",
         sha256: "7a4551cae82964e5359ebd0df645824a82539ad0f6a86b27fc399680aed767f7"
}

if version.end_with? 'all'
  dependency "python3"
end

relative_path "bcc"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  command "git init . && git add . && git commit -m 'dummy'"
  command "git tag v0.16.0"
  command "mkdir build"

  if version.end_with? 'all'
    command "cd build && cmake -DPYTHON_CMD=#{install_dir}/embedded/bin/python3.7 -DCMAKE_INSTALL_PREFIX=#{install_dir}/embedded ..", env: env
    command "cd build && make -j #{workers}", env: env
    command "cd build && make -j #{workers} install", env: env
    # python3 hack
    command "cd build/src/python && sed -i -e 's;.*--install-layout.*;COMMAND #{install_dir}/embedded/bin/python3.7 setup.py install -f --prefix=#{install_dir}/embedded;' cmake_install.cmake"
    command "cd build/src/python && make -j #{workers} install", env: env
  else
    command "cd build && cmake -DCMAKE_INSTALL_PREFIX=#{install_dir}/embedded ..", env: env
    command "cd build/src/cc && make -j #{workers}", env: env
    command "cd build/src/cc && make -j #{workers} install", env: env
  end
end
