module GithubbishAssets
  class RecursiveLister
    def self.[](root, ext)
      files = []

      root.find do |path|
        if path.file? && path.extname == ext
          files << path
        elsif path.directory? && path.basename.to_s[0] == ?.
          Find.prune
        end
      end

      files.sort
    end
  end
end
