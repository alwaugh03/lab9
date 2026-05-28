class VetPolicy < ApplicationPolicy
  def show?
    user.admin? || user.owner? || user.vet?
  end

  def update?
    return true if user.admin?

    user.vet? && record.user == user
  end

  def edit?
    update?
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.owner? || user.vet?
        scope.all
      else
        scope.none
      end
    end
  end
end