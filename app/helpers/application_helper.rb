module ApplicationHelper
  def badge_pill(content = nil, html_options = {})
    tag.span(class: "badge badge-pill #{html_options[:class]}", style: "font-size: 11px; #{html_options[:style]}") do
      content
    end
  end

  def fontawesome_icon(text, icon_class, style_css=nil)
    tag.i(text.to_s, class: icon_class, style: style_css)
  end

  def filter
    link_to '#', class: 'btn btn-outline-dark btn-sm btn-round my-3', style: 'font-size:12px;', type: 'button', data: { toggle: 'collapse', target: '#collapseSearch'}, aria: { expanded: false, controls: 'collapseSearch' } do
      content_tag :span, class: 'icon' do
        fontawesome_icon('', 'fa fa-filter')
      end
    end
  end

  def modal_to_new_resource(text, target: '', class_name: 'btn btn-outline-dark btn-sm btn-round my-sm-3', style_css: 'width:140px')
    link_to '#', class: class_name, data: { toggle: 'modal', target: target }, style: style_css do
      content_tag :span, class: 'icon' do
        content_tag :i, class: 'fa fa-plus-circle' do
          text
        end
      end
    end
  end

  def modal_to_pay_resource(text, target: '', width: '140px')
    link_to '#', class: 'btn-sm', data: { toggle: 'modal', target: target }, style:"width:#{width}" do
      fontawesome_icon(text, 'fa fa-money-bill')
    end
  end

  def link_to_show_resource(text, link)
    link_to link, class: 'btn-sm' do
      fontawesome_icon(text, 'fa fa-eye')
    end
  end

  def link_to_edit_resource(text, link)
    link_to link, class: 'btn-sm', style:'border-radius:10px;' do
      fontawesome_icon(text, 'fa fa-pencil')
    end
  end

  def link_to_delete_resource(text, link)
    link_to link, class: 'btn-sm', style:'border-radius: 10px;', method: :delete, data: { confirm: t('are_you_sure?') } do
      fontawesome_icon(text, 'fa fa-trash')
    end
  end

  def navlink_header(title=t(".title"))
    link_to params[:controller].to_s, class: 'navbar-brand navbar-link' do
      content_tag :span, class: 'icon' do
        title
      end
    end
  end

  def navbrand_link(text = t('.title'))
    link_to params[:controller].to_s, class: 'navbar-brand navbar-link mb-3', style: 'font-size: 17px;' do
      text
    end
  end
end
