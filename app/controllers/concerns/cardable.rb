module Cardable
  extend ActiveSupport::Concern

  # GET /model_class/cards.json
  def cards
    respond_to do |format|
      format.json do
        render json: find_all, each_serializer: CardSerializer
      end
    end
  end

  # GET /model_class/1/card.json
  def card
    respond_to do |format|
      format.json do
        render json: find_one, serializer: CardSerializer
      end
    end
  end

  protected

  def find_all
    paginate model_class.all(current_user)
  end

  def find_one
    model_class.new(model_variable, current_user)
  end

  def model_variable
    send("set_#{controller_name.singularize}".to_sym)
  end

  def model_class
    "Card::#{controller_name.classify}".constantize
  end
end
