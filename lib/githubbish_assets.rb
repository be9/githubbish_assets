require 'rails'
require 'active_support'
require 'githubbish_assets/lister'
require 'githubbish_assets/packer'
require 'githubbish_assets/helper'

module GithubbishAssets
  # The compressor used to compress javascript.
  # Might be :closure, :jsmin or :yui
  mattr_accessor :js_compressor
  @@js_compressor = :closure

  # Whether to create javascript source map or not.
  # Has sense only when js_compressor is set to :closure
  mattr_accessor :closure_source_map
  @@closure_source_map = false

  ###

  class Engine < Rails::Engine
    initializer 'githubbish_assets.helper' do |app|
      ActionView::Base.send :include, GithubbishAssets::Helper
    end

    rake_tasks do
      namespace :ghbundle do
        desc 'Create JS and CSS bundles'
        task :all => [ :js, :css ]

        desc 'Create JS bundles'
        task :js do
          verbose false

          Packer.js
        end

        desc 'Create CSS bundles'
        task :css do
          verbose false

          Packer.css
        end
      end
    end
  end
end
