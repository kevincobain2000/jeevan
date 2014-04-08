Chef::Log.info("Running deploy/before_migrate.rb in myapp app...")
current_release = release_path

execute "rake assets:precompile" do
  cwd current_release
  command "bundle exec rake assets:precompile"
  environment "RAILS_ENV" => 'production'
end
