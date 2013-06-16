class OthersController < ApplicationController
  skip_before_filter :authenticate_user!

  def djq
    render layout: false
    #render layout: "backbone"
  end

  def scratch_card
    render layout: false
  end
end
