class Card::Technology
  include Card

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
    @informations << [
      {
        icn: 'icons/cards/icn-posts.svg',
        title: "#{@model.activities.count} publicações"
      },
      {
        icn: 'icons/cards/icn-project.svg',
        title: "#{@model.projects.count} projectos"
      }
    ]

    super
  end
end
