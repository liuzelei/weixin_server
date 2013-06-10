class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  rescue_from Exceptions::UndetectedUserError , with: :undetected_user_error

  private
  def undetected_user_error(exception=nil)
    logger.error "Exception: #{exception.class}: #{exception.message}" if exception
    binding.pry
    respond_to do |format|
      format.html { render text: 'can not detect user', status: 500 }
      format.xml { render "message/undetected_user", status: 200 }
    end
  end
end
