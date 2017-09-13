# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

js_prefix    = 'app/assets/javascripts/'
style_prefix = 'app/assets/stylesheets/'
image_prefix    = 'app/assets/images/'

javascripts = Dir["#{js_prefix}**/*.js"].map      { |x| x.gsub(js_prefix,    '') }
css         = Dir["#{style_prefix}**/*.css"].map  { |x| x.gsub(style_prefix, '') }
image       = Dir["#{image_prefix}**/*"].map  { |x| x.gsub(image_prefix, '') }
scss        = Dir["#{style_prefix}**/*.scss"].map { |x| x.gsub(style_prefix, '') }
coffee        = Dir["#{js_prefix}**/*.coffee"].map { |x| x.gsub(js_prefix, '') }

Rails.application.config.assets.precompile = (javascripts + css + scss + coffee + image)
Rails.application.config.assets.precompile += %w( application.js )
Rails.application.config.assets.precompile += %w( i18n.js )
Rails.application.config.assets.precompile += %w( translations.js )
Rails.application.config.assets.precompile += Ckeditor.assets
Rails.application.config.assets.precompile += %w( ckeditor/* )
Rails.application.config.assets.precompile += %w( admin/new.js)
