name "sqlite3"
default_version "3.22.0"

source :url => "https://www.sqlite.org/2018/sqlite-autoconf-3220000.tar.gz",
       :sha256 => "2824ab1238b706bc66127320afbdffb096361130e23291f26928a027b885c612"

relative_path "sqlite-autoconf-3220000"

env = {
  "LDFLAGS" => "-Wl,-rpath,#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command "./configure --prefix=#{install_dir}/embedded --disable-readline", :env => env
  command "make -j #{workers}", :env => env
  command "make install"
end
