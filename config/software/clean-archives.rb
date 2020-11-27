name "clean-archives"
default_version "default"

build do
  block "Delete all of static archive files" do
    command "rm -rf #{install_dir}/embedded/lib/*.a"
  end
end
