class TreatmentPolicy < ApplicationPolicy
  def create?
    allowed_vet?
  end

  def update?
    allowed_vet?
  end

  def edit?
    update?
  end

  def destroy?
    allowed_vet?
  end

  def permitted_attributes
    attrs = [
      :name,
      :medication,
      :dosage,
      :clinical_notes,
      :administered_at
    ]

    attrs << :appointment_id if user.admin?

    attrs
  end

  private

  def allowed_vet?
    return true if user.admin?

    user.vet? &&
      record.appointment.vet.user == user
  end
end