class OwnerPolicy < ApplicationPolicy
  def show?
    user.admin? || user.vet? || own_record?
  end

  def update?
    user.admin? || own_record?
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
      if user.admin? || user.vet?
        scope.all
      elsif user.owner?
        scope.where(user: user)
      else
        scope.none
      end
    end
  end

  def permitted_attributes
    attrs = [
      :first_name,
      :last_name,
      :email,
      :phone,
      :address
    ]

    attrs << :user_id if user.admin?

    attrs
  end

  private

  def own_record?
    user.owner? && record.user == user
  end
end