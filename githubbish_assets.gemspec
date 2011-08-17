# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{githubbish_assets}
  s.version = "0.1.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Oleg Dashevskii"]
  s.date = %q{2011-08-17}
  s.description = %q{Github style assets bundling in a Rails 3 engine}
  s.email = %q{olegdashevski@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "githubbish_assets.gemspec",
    "lib/githubbish_assets.rb",
    "lib/githubbish_assets/capistrano.rb",
    "lib/githubbish_assets/helper.rb",
    "lib/githubbish_assets/lister.rb",
    "lib/githubbish_assets/packer.rb",
    "lib/vendor/js_minimizer.rb",
    "test/helper.rb",
    "test/test_githubbish_assets.rb"
  ]
  s.homepage = %q{http://github.com/be9/githubbish_assets}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.9.2}
  s.summary = %q{Github style assets bundling}
  s.test_files = [
    "test/helper.rb",
    "test/test_githubbish_assets.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<closure-compiler>, [">= 0"])
      s.add_runtime_dependency(%q<yui-compressor>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_dependency(%q<closure-compiler>, [">= 0"])
      s.add_dependency(%q<yui-compressor>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.0.0"])
    s.add_dependency(%q<closure-compiler>, [">= 0"])
    s.add_dependency(%q<yui-compressor>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

