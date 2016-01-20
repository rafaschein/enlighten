class Card::Client
  include Card

  def path
    "Clientes"
  end

  def title
    @model.name
  end

  def informations
    @informations << [
      {
        icn: 'icons/cards/icn-project.svg',
        title: "#{@model.projects.count} projetos"
      }
    ]

    super
  end
end
