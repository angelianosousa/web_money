module ApplicationHelper
  def badge_pill(content = nil, html_options = {})
    tag.span(class: "badge badge-pill #{html_options[:class]}", style: "font-size: 11px; #{html_options[:style]}") do
      content
    end
  end
end
