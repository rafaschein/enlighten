class CardSerializer < ActiveModel::Serializer
  attributes :type, :path, :avatar, :title, :subtitle, :informations, :statistics, :links
end
