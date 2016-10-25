class Sprockets::Vue::Style
  class << self
    STYLE_COMPILES = {
      'scss' => Sprockets::ScssProcessor,
      'sass' => Sprockets::SassProcessor,
      nil => ->(i){i[:data]}
    }
    def call(input)
      data = input[:data]
      input[:cache].fetch([cache_key, input[:filename], data]) do
        style_r = /\<style *(lang="(\w+)")?\>([\s\S]+)\<\/style\>/
        style = style_r.match(data)
        if style
          lang = style[2]
          input[:data] = style[3]
          STYLE_COMPILES[lang].call(input)
        else
          ''
        end
      end
    end

    def cache_key
      [
        self.name,
        ::Sprockets::Vue::VERSION,
      ].freeze
    end
  end
end
