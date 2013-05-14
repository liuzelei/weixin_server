module MenuHelper
  def current_menu_item_state(action="",controller="")
    if controller.present?
      "active" if action==params[:action] and controller==params[:controller]
    else
      "active" if action==params[:action]
    end
  end

end
