class PetPolicy < ApplicationPolicy
  def show?
    return true if user.admin? || user.vet?

    user.owner? && record.owner.user == user
  end

  def create?
    user.admin? || user.owner?
  end

  def update?
    return true if user.admin?

    user.owner? && record.owner.user == user
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def permitted_attributes
    attrs = [
      :name,
      :species,
      :breed,
      :date_of_birth,
      :weight,
      :photo
    ]

    attrs << :owner_id if user.admin?

    attrs
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      elsif user.owner?
        scope.joins(:owner)
             .where(owners: { user_id: user.id })
      else
        scope.none
      end
    end
  end
end