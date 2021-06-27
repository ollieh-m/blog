module ApplicationHelper
  def icon(name, **options)
    inline_svg_pack_tag "media/icons/#{name}.svg", options
  end
end
