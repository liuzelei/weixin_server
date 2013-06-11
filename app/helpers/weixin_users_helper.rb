module WeixinUsersHelper
  def detect_current_user
    #weixin_id = params[:xml] ? params[:xml][:ToUserName] : nil
    #user = User.includes(:setting).where("settings.weixin_id"=>weixin_id).first if weixin_id.present?
    user_id = params[:user_id]
    user = User.find_by_id user_id
    if user
      sign_in user
    else
      raise Exceptions::UndetectedUserError
    end
  end
end
