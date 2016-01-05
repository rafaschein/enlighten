class Card::Technology
  attr_reader :path, :title, :subtitle, :informations

  def initialize(model)
    @model = model
  end

  def path
    "Conhecimentos"
  end

  def title
    @model.name
  end

  def subtitle
    @model.category.name
  end

  def informations
    [
      {
        icn: 'icons/cards/icn-posts.svg',
        title: "#{@model.activities.count} publicações"
      },
      {
        icn: 'icons/cards/icn-project.svg',
        title: "#{@model.projects.count} projectos"
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
