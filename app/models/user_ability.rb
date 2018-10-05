class UserAbility
    include CanCan::Ability
    def initialize(user)
        cannot :manage, :all
        can :create, [User]
        can :complete, [User]
        can :manage, [User, Device, Certification] if user
    end
end
