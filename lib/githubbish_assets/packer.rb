require 'yui/compressor'
require 'find'

module GithubbishAssets
  class Packer
    def self.js
      case GithubbishAssets.js_compressor
      when :jsmin
        require 'vendor/js_minimizer'
      when :closure
        require 'closure-compiler'
      end

      pack('public/javascripts', '.js') do |target, files|
        case GithubbishAssets.js_compressor
        when :closure
          opts = [ [:js_output_file, target] ]

          if GithubbishAssets.closure_source_map
            opts << [:create_source_map, "#{target}.map"]
          end

          files.each do |file|
            opts << [:js, file]
          end

          Closure::Compiler.new(opts).compile('')
        when :yui
          compress_with_yui(YUI::JavaScriptCompressor.new, files, target)
        else
          File.open(target, 'w+') do |f|
            f.puts GithubbishAssets::JSMinimizer.minimize_files(*files)
          end
        end
      end
    end

    def self.css
      pack('public/stylesheets', '.css') do |target, files|
        compress_with_yui(YUI::CssCompressor.new(:line_break => 0), files, target)
      end
    end

    def self.recursive_file_list(basedir, ext)
      files = []
      Find.find(basedir) do |path|
        if FileTest.directory?(path)
          if File.basename(path)[0] == ?. # Skip dot directories
            Find.prune
          else
            next
          end
        end
        files << path if File.extname(path) == ext
      end
      files.sort
    end


    private

    def self.pack(relpath, ext)
      targets = []
      get_top_level_directories(relpath).each do |bundle_directory|
        bundle_name = bundle_directory.basename

        files = recursive_file_list(bundle_directory, ext)
        next if files.empty? || bundle_name == 'dev'

        target = Rails.root + relpath + "bundle_#{bundle_name}#{ext}"

        yield target, files

        targets << target
      end

      targets
    end

    def self.get_top_level_directories(base_path)
      Dir.entries(Rails.root + base_path).collect do |path|
        if path[0] != ?. && (Rails.root + base_path + path).directory?
          path
        end
      end.compact
    end

    def self.compress_with_yui(compressor, files, target)
      File.open(target, 'w') do |f|
        compressor.compress(MultiFile.new(files)) do |compressed|
          while buffer = compressed.read(4096)
            f.write(buffer)
          end
        end
      end
    end

    # A class that emulates continuous reading from a bunch of files
    class MultiFile
      def initialize(files)
        @files = files
        @file = nil
      end

      def read(size)
        while true
          if @file
            res = @file.read(size)

            return res if res
          end

          return if @files.empty?

          @file = File.open(@files.shift, 'r')
        end
      end
    end
  end
end
