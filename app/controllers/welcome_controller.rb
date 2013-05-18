class WelcomeController < ApplicationController
  after_filter :test_filter

  def index
  end

  def test
    @abc = "dev"
    render :test_template, format: :html
  end

  private
  def test_filter
  end
end
