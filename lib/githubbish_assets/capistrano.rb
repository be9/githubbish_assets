Capistrano::Configuration.instance(:must_exist).load do
  namespace :deploy do
    desc "Shrink and bundle js and css"
    task :bundle, :roles => :web, :except => { :no_release => true } do
      run "cd #{release_path}; RAILS_ROOT=#{release_path} #{fetch(:rake, 'rake')} ghbundle:all RAILS_ENV=#{fetch(:rails_env, 'production')}"
    end

    desc "Shrunk and bundle js and css locally, then upload"
    task :local_bundle, :roles => :web, :except => { :no_release => true } do
      puts ">>> Bundling locally"
      system "bundle exec rake ghbundle:all RAILS_ENV=#{fetch(:rails_env, 'production')}"

      Dir["public/javascripts/bundle_*.js", "public/stylesheets/bundle_*.css"].each do |file|
        top.upload file, "#{release_path}/#{file}"
      end
    end
  end

  if fetch(:bundle_locally, false)
    after "deploy:update_code", "deploy:bundle"
  else
    after "deploy:update_code", "deploy:local_bundle"
  end
end
