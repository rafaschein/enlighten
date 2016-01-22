class CardsController < ApplicationController
  # GET /cards.json
  def index
    @cards = paginate Card.all(current_user)
    authorize :card, :index?

    respond_to do |format|
      format.json { render json: @cards, each_serializer: CardSerializer }
    end
  end
end
