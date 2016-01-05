class Card::Person
  attr_reader :path, :title, :subtitle, :informations

  def initialize(model)
    @model = model
  end

  def path
    "Pessoas"
  end

  def title
    @model.name
  end

  def subtitle
  end

  def informations
    [
      {
        icn: 'icons/cards/icn-role.svg',
        title: last_membership.role.name
      },
      {
        icn: 'icons/cards/icn-project.svg',
        title: last_membership.project.name
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

  private

  def last_membership
    @model.memberships.last
  end
end
