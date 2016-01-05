class CardsController < ApplicationController
  # GET /cards.json
  def index
    @cards = paginate Card.all

    respond_to do |format|
      format.json { render json: @cards }
    end
  end
end
