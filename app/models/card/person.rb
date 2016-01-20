class Card::Person
  include Card

  def path
    "Pessoas"
  end

  def title
    @model.name
  end

  def informations
    @informations << [
      {
        icn: 'icons/cards/icn-role.svg',
        title: last_membership.role.name
      },
      {
        icn: 'icons/cards/icn-project.svg',
        title: last_membership.project.name
      }
    ] unless last_membership.nil?

    super
  end

  private

  def last_membership
    @model.memberships.last unless @model.memberships.nil?
  end
end
