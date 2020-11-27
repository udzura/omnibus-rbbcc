name "clean-archives"
default_version "default"

build do
  block "Delete all of static archive files" do
    command "rm -rf #{install_dir}/embedded/lib/*.a"
  end

  block "Delete unnecessary and big binaries" do
    ["eu-*", "openssl"].each do |glob|
      command "rm -rf #{install_dir}/embedded/bin/#{glob}"
    end
  end
end
