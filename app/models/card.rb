class Card
  attr_accessor :path, :avatar, :title, :subtitle, :informations, :statistics

  def initialize(model)
    @model = model
  end

  def path
    @model.path
  end

  def avatar
    helpers.attachment_url(@model.instance_variable_get(:@model), :image, :fill, 300, 300, format: 'png')
  end

  def title
    @model.title
  end

  def subtitle
    @model.subtitle
  end

  def informations
    (@model.informations || []).map do |information|
      information[:icn] = helpers.image_url information[:icn]
      information
    end
  end

  def statistics
    if @model.respond_to?(:statistics)
      (@model.statistics || []).map do |statistic|
        statistic[:icn] = helpers.image_url statistic[:icn]
        statistic
      end
    end
  end

  def read_attribute_for_serialization(attribute)
    self.send(attribute)
  end

  def self.all
    (::Technology.all | ::Person.all | ::Client.all | ::Project.all).sort_by(&:updated_at).map do |model|
      Card.new("Card::#{model.class.name}".constantize.new(model))
    end
  end

  private

  def helpers
    ApplicationController.helpers
  end
end
