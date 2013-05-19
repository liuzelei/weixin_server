class WelcomeController < ApplicationController
  after_filter :test_filter

  def index
  end

  def test
    @abc = "dev"
    logger.info request.location.latitude
    render :test_template, format: :html
  end

  private
  def test_filter
  end
end
