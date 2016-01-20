class Card::Project
  include Card

  def path
    "Projetos"
  end

  def title
    @model.name
  end

  def subtitle
    @model.client.name unless @model.client.nil?
  end

  def informations
    @informations << [
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

    super
  end
end
