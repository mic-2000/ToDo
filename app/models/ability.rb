class Ability
  include CanCan::Ability

  def initialize(user)

    if user
      can :manage, Project, :user_id => user.id

      can :manage, Task do |task|
        can?(:manage, task.project)
      end

      can :manage, Comment do |comment|
        can?(:manage, comment.task)
      end
    end
  end
end
