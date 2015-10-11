module Jekyll
  class Height < Liquid::Tag

    def render(context)
      meters = Integer(@markup.strip)
      feet = (3.281 * meters).round
      "<span class='altitude'>(#{meters} m / #{feet} ft)</span>"
    end
  end
end

Liquid::Template.register_tag('height', Jekyll::Height)
