module GithubbishAssets
  module Helper
    def bundle_files?
      Rails.env.production? || Rails.env.staging? || params[:bundle] || cookies[:bundle] == "yes"
    end

    def js_use(*bundles)
      @js_bundles = ((@js_bundles || []) + bundles.map(&:to_s)).compact.uniq
    end

    def css_use(*bundles)
      @css_bundles = ((@css_bundles || []) + bundles.map(&:to_s)).compact.uniq
    end

    def javascript_bundle(*sources)
      sources = sources.to_a
      bundle_files? ? javascript_include_bundles(sources) : javascript_include_files(sources)
    end

    # This method assumes you have manually bundled js using a rake command
    # or similar. So there better be bundle_* files.
    def javascript_include_bundles(bundles)
      output = ""
      bundles.each do |bundle|
        output << javascript_src_tag("bundle_#{bundle}", {}) + "\n"
      end
      output.html_safe
    end

    def javascript_include_files(bundles)
      _gh_include_files("public/javascripts", ".js", bundles) { |file| javascript_src_tag(file, {}) }
    end

    def javascript_dev(*sources)
      output = ""
      sources = sources.to_a
      dev = Rails.env.development? || Rails.env.test?
      sources.each do |pair|
        output << javascript_src_tag(dev ? "dev/#{pair[0]}" : pair[1], {})
      end
      output.html_safe
    end

    def stylesheet_bundle(*sources)
      sources = sources.to_a
      bundle_files? ? stylesheet_include_bundles(sources) : stylesheet_include_files(sources)
    end

    # This method assumes you have manually bundled css using a rake command
    # or similar. So there better be bundle_* files.
    def stylesheet_include_bundles(bundles)
      stylesheet_link_tag(bundles.collect{ |b| "bundle_#{b}"})
    end

    def stylesheet_include_files(bundles)
      _gh_include_files("public/stylesheets", ".css", bundles) { |file| stylesheet_link_tag(file) }
    end

    private

    def _gh_include_files(asset_root, ext, bundles)
      p_asset_root = Rails.root + asset_root
      output = ""

      bundles.each do |bundle|
        files = RecursiveLister[p_asset_root + bundle.to_s, ext]
        files.each do |file|
          output << yield(file.relative_path_from(p_asset_root).to_s) << "\n"
        end
      end

      output.html_safe
    end
  end
end
