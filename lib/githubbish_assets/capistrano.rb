Capistrano::Configuration.instance(:must_exist).load do
  namespace :deploy do
    desc "Shrink and bundle js and css"
    task :bundle, :roles => :web, :except => { :no_release => true } do
      run "cd #{release_path}; RAILS_ROOT=#{release_path} #{fetch(:rake, 'rake')} ghbundle:all RAILS_ENV=#{fetch(:rails_env, 'production')}"
    end
  end

  after "deploy:update_code", "deploy:bundle"
end
