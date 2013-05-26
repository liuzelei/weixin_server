class WelcomeController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:auth]

  def index
  end

  def auth
    render :text => params[:echostr]
  end

  def test
    @abc = "dev"
    logger.info request.location.latitude
    render :test_template, format: :html
  end

  def test1
    render text: "just test"
  end

end
