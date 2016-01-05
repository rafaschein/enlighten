class Card::Client
  attr_reader :title, :subtitle, :informations, :statistics

  def initialize(model)
    @model = model
  end

  def path
    "Clientes"
  end

  def title
    @model.name
  end

  def subtitle
  end

  def informations
    [
      {
        icn: 'icons/cards/icn-project.svg',
        title: "#{@model.projects.count} projetos"
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
