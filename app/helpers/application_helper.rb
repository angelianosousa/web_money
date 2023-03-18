module ApplicationHelper
  def badge_pill(content = nil, html_options = {})
    tag.span(class: "badge badge-pill #{html_options[:class]}", style: "font-size: 11px; #{html_options[:style]}") do
      content
    end
  end

  def fontawesome_icon(text, icon_class)
    tag.i("#{text}", class: "#{icon_class}")
  end

  def filter
    link_to '#', class:'btn btn-outline-dark btn-sm btn-round my-sm-3', type:"button", data: { toggle: 'collapse', target: '#collapseSearch'}, aria: { expanded: false, controls: 'collapseSearch' } do
      content_tag :span, class:'icon' do
        fontawesome_icon('', 'fa fa-filter')
      end
    end
  end

  def modal_to_new_resource(text, target: '')
    link_to '#', class: "btn btn-outline-dark btn-sm btn-round my-sm-3", "data-toggle":"modal", "data-target":"#{target}", style:"width:140px" do
      "#{fontawesome_icon(text, 'fa fa-plus-square')}".html_safe
    end
  end

  def modal_to_pay_resource(text, target: '', width: '140px')
    link_to '#', class: "btn-sm", data: { toggle: "modal", target: "#{target}"}, style:"width:#{width}" do
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

  # TODO | Criar um metodo para juntar a criação de recorrência, conta e movimentação no dropdown
  def dropdown_for_new_resource
    content_tag :div, class:'dropdown dropleft' do
      link_to '#', class:'btn btn-outline-dark btn-sm btn-round', id:'dropdownActionButton', "data-toggle":"dropdown", "aria-haspopup":"true", "aria-expanded":"false" do
        content_tag :span, class:'icon' do
          content_tag :i, class:'fa fa-sort-desc'
        end
      end
    end
  end
end

# <div class="dropdown dropleft">
#   <%= link_to '#', class:'btn btn-outline-dark btn-sm btn-round', id:'dropdownActionButton', "data-toggle":"dropdown", "aria-haspopup":"true", "aria-expanded":"false" do %>
#     <span class='icon'><i class='fa fa-sort-desc'></i></span>
#   <% end %>
#   <div class="dropdown-menu" aria-labelledby="dropdownActionButton">
#     <%= link_to bill_path(bill), class:'dropdown-item', style:'font-size:15px;' do %>
#       <span class='icon'><i class="fa fa-eye pull-right" style='font-size:18px;'></i></span> Editar
#     <% end %>
#     <%= link_to edit_bill_path(bill), class:'dropdown-item', style:'font-size:15px;' do %>
#       <span class='icon'><i class="fa fa-pencil pull-right" style='font-size:18px;'></i></span> Editar
#     <% end %>
#     <%= link_to bill_path(bill), class:'dropdown-item', style:'font-size:15px;', method: :delete, data: { confirm: t('are_you_sure?') } do %>
#       <span class='icon'><i class="fa fa-trash pull-right" style='font-size:18px;'></i></span> Deletar
#     <% end %>
#     <%= link_to '#', class: "dropdown-item", style:'font-size:15px;', "data-toggle":"modal", "data-target":"#paymentModal_#{bill.id}" do %>
#       <span class='icon'><i class="fa fa-money pull-right" style='font-size:18px;'></i></span> Pagar
#     <% end %>
#   </div>
# </div>
