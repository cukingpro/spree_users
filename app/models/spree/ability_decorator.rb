class AbilityDecorator
  include CanCan::Ability
  def initialize(user)
    can :manage, Spree::Shipment
    can :manage, Spree::Payment
  end
end

Spree::Ability.register_ability(AbilityDecorator)