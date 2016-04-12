class AbilityDecorator
  include CanCan::Ability
  def initialize(user)
    can :manage, Spree::Shipment
  end
end

Spree::Ability.register_ability(AbilityDecorator)