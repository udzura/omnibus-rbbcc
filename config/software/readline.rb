name "readline"
default_version "6.3"

# http://buildroot-busybox.2317881.n4.nabble.com/PATCH-readline-link-directly-against-ncurses-td24410.html
# https://bugzilla.redhat.com/show_bug.cgi?id=499837
# http://lists.osgeo.org/pipermail/grass-user/2003-September/010290.html
# http://trac.sagemath.org/attachment/ticket/14405/readline-tinfo.diff
dependency "ncurses5"

source :url => "https://ftp.gnu.org/gnu/readline/readline-6.3.tar.gz",
       :sha256 => "56ba6071b9462f980c5a72ab0023893b65ba6debb4eeb475d7a563dc65cafd43"

relative_path "#{name}-#{version}"

build do
  env = {
      "CFLAGS" => "-I#{install_dir}/embedded/include",
      "LDFLAGS" => "-Wl,-rpath,#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib"
  }

  configure_command = [
      "./configure",
      "--with-curses",
      "--prefix=#{install_dir}/embedded"
  ].join(" ")

  patch :source => "readline-6.2-curses-link.patch" , plevel: 1
  command configure_command, env: env
  command "make -j #{workers}", env: env
  command "make -j #{workers} install", env: env
end
