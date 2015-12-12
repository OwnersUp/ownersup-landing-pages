require "slim"
require "extensions/views"

::Slim::Engine.set_options pretty: true, format: :html

set :url_root, 'http://docs.ownersup.com'

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'images'
set :fonts_dir, 'fonts'
set :partials_dir, '_partials'
page "/faq/*/*", :layout => "article"

set :markdown_engine, :redcarpet
set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true, with_toc_data: true

activate :views
activate :directory_indexes
activate :search_engine_sitemap

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-65107405-4'
end

configure :development do
 activate :livereload
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :minify_html
  # activate :asset_hash

  # Compress and optimise images during build
  # Documentation: https://github.com/plasticine/middleman-imageoptim
  activate :imageoptim do |options|
    # Image extensions to attempt to compress
    options.image_extensions = %w(.png .jpg .gif .svg)
    # Cause image_optim to be in shouty-mode
    options.verbose = false
  end

end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
end

activate :bower
after_configuration do
  sprockets.append_path File.join root.to_s, "vendor/assets/bower"
end

helpers do
  def table_of_contents(resource)
    content = File.read(resource.source_file)
    content = content.gsub(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m,'')
    toc_renderer = Redcarpet::Render::HTML_TOC.new

    markdown = Redcarpet::Markdown.new(toc_renderer, nesting_level: 1) # nesting_level is optional
    html = markdown.render(content)
    html.sub(/^<ul>/, '<ul class="nav">')
  end
end

ready do
end
