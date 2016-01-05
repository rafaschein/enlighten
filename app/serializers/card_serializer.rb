class CardSerializer < ActiveModel::Serializer
  attributes :path, :avatar, :title, :subtitle, :informations, :statistics
end
