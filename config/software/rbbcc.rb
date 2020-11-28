name "rbbcc"
default_version "v0.6.4"

dependency "ruby"
dependency "bcc"

license "Apache-2.0"
skip_transitive_dependency_licensing true

source git: "https://github.com/udzura/rbbcc.git"
relative_path "rbbcc"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  env.merge!("LD_LIBRARY_PATH" => "#{install_dir}/embedded/lib")

  bundle "install --without plugin_dev", env: env
  bundle "exec rake install", env: env
  bundle "binstubs appbundler --path #{install_dir}/embedded/bin", env: env
  # To replace embedded bundle command itself
  home = ENV['HOME'] || '/root'
  command "#{home}/.rbenv/shims/bundle binstubs bundler --force --path #{install_dir}/embedded/bin", env: env

  # gem "build #{gemspec_name}", env: env

  block do
    appbundle "rbbcc", lockdir: project_dir, gem: "rbbcc", env: env
  end
end
