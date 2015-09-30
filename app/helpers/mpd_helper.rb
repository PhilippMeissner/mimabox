module MpdHelper
  def link_to_glyph(text, link, icon)
    link_to content_tag(:span, " #{text}", class: "btn btn-primary glyphicon glyphicon-#{icon}"), link, method: :post
  end
end
