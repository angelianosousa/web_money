module ApplicationHelper
  def badge_pill(content = nil, html_options = {})
    tag.span(class: "badge badge-pill #{html_options[:class]}", style: "font-size: 11px; #{html_options[:style]}") do
      content
    end
  end

  def fontawesome_icon(text, icon_class, style_css='')
    tag.i("#{text}", class: icon_class, style: style_css)
  end

  def filter
    link_to '#', class:'btn btn-outline-dark btn-sm btn-round my-sm-3', type:"button", data: { toggle: 'collapse', target: '#collapseSearch'}, aria: { expanded: false, controls: 'collapseSearch' } do
      content_tag :span, class:'icon' do
        fontawesome_icon('', 'fa fa-filter')
      end
    end
  end

  def modal_to_new_resource(text, target: '', class_name: 'btn btn-outline-dark btn-sm btn-round my-sm-3', style_css: 'width:140px')
    link_to '#', class: class_name, data: { toggle: 'modal', target: target}, style: style_css do
      "#{fontawesome_icon(text, 'fa fa-plus-square')}".html_safe
    end
  end

  def modal_to_pay_resource(text, target: '', width: '140px')
    link_to '#', class: "btn-sm", data: { toggle: "modal", target: target}, style:"width:#{width}" do
      "#{fontawesome_icon(text, 'fa fa-money')}".html_safe
    end
  end

  def link_to_show_resource(text, link)
    link_to link, class: 'btn-sm' do
      "#{fontawesome_icon(text, 'fa fa-eye')}".html_safe
    end
  end

  def link_to_edit_resource(text, link)
    link_to link, class: 'btn-sm', style:'border-radius:10px;' do
      "#{fontawesome_icon(text, 'fa fa-pencil')}".html_safe
    end
  end

  def link_to_delete_resource(text, link)
    link_to link, class: 'btn-sm', style:'border-radius: 10px;', method: :delete, data: { confirm: t('are_you_sure?') } do
      "#{fontawesome_icon(text, 'fa fa-trash')}".html_safe
    end
  end

  def header_icon
    {
      'dashboard' => 'fa fa-bar-chart',
      'accounts' => 'fa fa-bank',
      'plans' => 'fa fa-map-o',
      'transactions' => 'fa fa-exchange',
      'categories' => 'fa fa-list',
      'bills' => 'fa fa-refresh'
    }
  end

  def navlink_header(title=t(".title"))
    link_to "#{params[:controller]}", class: 'navbar-brand navbar-link' do
      content_tag :span, class:'icon' do
        title
      end
    end
  end
end
