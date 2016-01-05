class Card::Project
  attr_reader :path, :title, :subtitle, :informations

  def initialize(model)
    @model = model
  end

  def path
    "Projetos"
  end

  def title
    @model.name
  end

  def subtitle
    @model.client.name
  end

  def informations
    [
      {
        icn: 'icons/cards/icn-posts.svg',
        title: "#{@model.activities.count} publicações"
      },
      {
        icn: 'icons/cards/icn-knowledges.svg',
        title: "#{@model.technologies.count} conhecimentos"
      },
      {
        icn: 'icons/cards/icn-members.svg',
        title: "#{@model.members.count} participantes"
      }
    ]
  end

  def statistics
    [
      {
        icn: 'icons/cards/icn-likers.svg',
        link: '#',
        title: @model.likers.count
      },
      {
        icn: 'icons/cards/icn-followers.svg',
        link: '#',
        title: @model.followers.count
      }
    ]
  end
end
