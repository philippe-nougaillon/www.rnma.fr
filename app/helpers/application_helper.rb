module ApplicationHelper

    # FRONT
    def navbar_item(action_name, path, label = nil)

        is_active = params[:action] == action_name

        render(inline: %{
            <%= link_to '#{ url_for(path) }', 
                        class: 'navbar-item #{ 'is-active' if is_active }' do %>
                #{ label ? label : action_name.humanize }
            <% end %>
        })
    end

    # BACK
    def navbar_nav_item(controller_logo ,controller_name, path, label = nil)

        is_active = params[:controller] == controller_name

        render(inline: %{
            <%= link_to '#{ url_for(path) }', 
                        class: 'navbar-item #{ 'is-active' if is_active }' do %>
                <i class="fas fa-#{controller_logo} mr-1"></i>
                #{ label ? label : controller_name.humanize }
            <% end %>
        })
    end

    def sort_link(column, title = nil)
        title ||= (@model_class ? @model_class.human_attribute_name(column) : column.titleize)
        
        direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
        
        icon = sort_direction == "asc" ? "fas fa-sort-up" : "fas fa-sort-down"
        icon = column == sort_column ? icon : ""
        
        link_title = sort_direction == "asc" ? "Trier croissant" : "Trier décroissant"

        link_to "<span class='btn btn-sm' title=\"#{h link_title}\">#{h title} <i class=\"#{icon}\"></i></span>".html_safe, 
                url_for(request.parameters.merge(column: column, direction: direction))
    end
end
