module Card
  def self.included(base)
    base.extend(ClassMethods)
  end

  def initialize(model, current_user)
    @model = model
    @current_user = current_user
    @informations = []
    @statistics = []
  end

  def type
    @model.class.name.demodulize.downcase
  end

  def path
  end

  def avatar
    helpers.attachment_url(@model, :image, :fill, 300, 300, format: 'png')
  end

  def title
  end

  def subtitle
  end

  def informations
    (@informations.flatten || []).map do |information|
      information[:icn] = helpers.image_url(information[:icn])
      information
    end
  end

  def statistics
    likable
    followable

    (@statistics.flatten || []).map do |statistic|
      statistic[:icn] = helpers.image_url(statistic[:icn])
      statistic
    end
  end

  def links
    {
      self: model_path,
      card: "#{model_path}/card.json"
    }
  end

  def read_attribute_for_serialization(attribute)
    send(attribute)
  end

  def helpers
    ApplicationController.helpers
  end

  module ClassMethods
    def all(current_user)
      name.demodulize.constantize.order([updated_at: :desc]).map do |model|
        new(model, current_user)
      end
    end
  end

  def self.all(current_user)
    [::Person.all | ::Client.all | ::Technology.all | ::Project.all].flatten.map do |model|
      "Card::#{model.class.name}".constantize.new(model, current_user)
    end
  end

  private

  def likable?
    @current_user.respond_to?("liked_#{@model.class.name.pluralize.downcase}".to_sym)
  end

  def liked?
    @current_user.send("liked_#{@model.class.name.pluralize.downcase}").include?(@model)
  end

  def followable?
    @current_user.respond_to?("followed_#{@model.class.name.pluralize.downcase}".to_sym)
  end

  def followed?
    @current_user.send("followed_#{@model.class.name.pluralize.downcase}").include?(@model)
  end

  def likable
    return unless likable?

    if liked?
      @statistics << { icn: 'icons/cards/icn-likers-selected.svg', link: "#{model_path}/unlike.json", title: @model.likers.count }
    else
      @statistics << { icn: 'icons/cards/icn-likers.svg', link: "#{model_path}/like.json", title: @model.likers.count }
    end
  end

  def followable
    return unless followable?

    if followed?
      @statistics << { icn: 'icons/cards/icn-followers-selected.svg', link: "#{model_path}/unfollow.json", title: @model.followers.count }
    else
      @statistics << { icn: 'icons/cards/icn-followers.svg', link: "#{model_path}/follow.json", title: @model.followers.count }
    end
  end

  def model_path
    "/#{@model.class.name.pluralize.downcase}/#{@model.id}"
  end
end
