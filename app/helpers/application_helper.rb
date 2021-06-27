module ApplicationHelper
  def icon(name, **options)
    inline_svg_pack_tag "media/images/#{name}.svg", options
  end
end
