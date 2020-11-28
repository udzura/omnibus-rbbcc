# Original: https://github.com/dyim42/omnibus-python3/blob/master/config/software/python3.rb

name "python3"
default_version "3.7.9"

dependency "readline"
dependency "sqlite3"
dependency "gdbm"
dependency "ncurses5"
dependency "zlib"
dependency "openssl"
dependency "libbz2"
dependency "ffi"
dependency "libuuid1"

source :url => "http://python.org/ftp/python/#{version}/Python-#{version}.tgz",
       :sha256 => '39b018bc7d8a165e59aa827d9ae45c45901739b0bbb13721e4f973f3521c166a'

relative_path "Python-#{version}"

LIB_PATH = %W(#{install_dir}/embedded/lib #{install_dir}/embedded/lib64 #{install_dir}/embedded/libexec #{install_dir}/lib #{install_dir}/lib64 #{install_dir}/libexec)

env = {
  "CFLAGS" => "-I#{install_dir}/embedded/include -O3 -g -pipe",
  "LDFLAGS" => "-Wl,-rpath,#{LIB_PATH.join(',-rpath,')} -L#{LIB_PATH.join(' -L')} -I#{install_dir}/embedded/include"
}

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--enable-shared"].join(" "), env: env
  command "make -j #{workers}", env: env
  command "make -j #{workers} install", env: env

  block "Clean *.pyc from package. These will be regenerated" do
    command "find #{install_dir}/embedded/lib -name '*.pyc' | xargs rm -f"
  end

  block "Clean unnecessary files and packages for tool use" do
    command "rm -rf #{install_dir}/embedded/lib/python3.7/config-3.7m-x86_64-linux-gnu #{install_dir}/embedded/lib/python3.7/test"
  end
end
