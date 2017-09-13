class AdminAbility
    include CanCan::Ability
    def initialize(admin)
        if admin
            can :read, [AdminHome]
            if admin.role? :administrator
                can :manage, :all
            elsif admin.role? :operator
                can :manage, :all
                cannot :read, [Operator]
            elsif admin.role? :exporter
                can :manage,  [User]
            elsif admin.role? :reader
                can :read, :all
                cannot :read, [Operator]
            end
        else
            cannot :manage, :all
        end
    end
end
