class Hd::ScratchCardsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]
  # GET /hd/scratch_cards
  # GET /hd/scratch_cards.json
  def index
    #@hd_scratch_cards = Hd::ScratchCard.all
    @hd_scratch_cards = current_user.scratch_cards

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hd_scratch_cards }
    end
  end

  # GET /hd/scratch_cards/1
  # GET /hd/scratch_cards/1.json
  def show
    @hd_scratch_card = Hd::ScratchCard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hd_scratch_card }
    end
  end

end
