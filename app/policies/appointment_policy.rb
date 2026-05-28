class AppointmentPolicy < ApplicationPolicy
  def show?
    return true if user.admin?

    if user.vet?
      record.vet.user == user
    elsif user.owner?
      record.pet.owner.user == user
    else
      false
    end
  end

  def create?
    user.admin? || user.owner? || user.vet?
  end

  def update?
    return true if user.admin?

    if user.vet?
      record.vet.user == user
    elsif user.owner?
      record.pet.owner.user == user
    else
      false
    end
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def permitted_attributes
    attrs = [
      :date,
      :reason,
      :status
    ]

    if user.admin?
      attrs += [:pet_id, :vet_id]
    elsif user.owner?
      attrs += [:vet_id]
    elsif user.vet?
      attrs += [:pet_id]
    end

    attrs
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.vet?
        scope.joins(:vet)
             .where(vets: { user_id: user.id })
      elsif user.owner?
        scope.joins(pet: :owner)
             .where(owners: { user_id: user.id })
      else
        scope.none
      end
    end
  end
end