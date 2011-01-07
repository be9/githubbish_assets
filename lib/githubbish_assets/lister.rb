module GithubbishAssets
  class RecursiveLister
    def self.[](root, ext)
      files = []

      root.find do |path|
        files << path if path.file? && path.extname == ext
      end

      files.sort
    end
  end
end
