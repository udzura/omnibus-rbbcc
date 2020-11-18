name "llvm-clang"
dependency "cmake"

default_version "10.0.1"

version("10.0.1") {
  source url: "https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz",
         sha256: "48b83ef827ac2c213d5b64f5ad7ed082c8bcb712b46644e0dc5045c6f462c231"
}

relative_path "clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04"

build do
  %w(bin include lib libexec share).each do |dir|
    command "mkdir -p #{install_dir}/embedded/#{dir} && cp -r #{dir}/* #{install_dir}/embedded/#{dir}/"
  end
end
