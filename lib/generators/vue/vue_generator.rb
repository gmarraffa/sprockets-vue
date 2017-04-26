require 'rails/generators/base'
class VueGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :lang, type: :string, default: 'js'

  def generate_vue
    template 'tpl.vue.erb', "app/assets/javascripts/#{file_path}.vue"
  end
end
