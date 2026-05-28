class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = policy_scope(
      Appointment.includes(:pet, :vet)
    )
  end

  def show
    @appointment = Appointment.includes(
      treatments: :rich_text_clinical_notes
    ).find(params[:id])

    authorize @appointment
  end

  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  def create
    @appointment = Appointment.new(
      permitted_attributes(Appointment)
    )

    authorize @appointment

    if current_user.owner?
      @appointment.pet =
        current_user.owner.pets.find(params[:pet_id])
    end

    if @appointment.save
      redirect_to @appointment,
                  notice: "Appointment created."
    else
      render :new,
             status: :unprocessable_entity
    end
  end

  def edit
    authorize @appointment
  end

  def update
    authorize @appointment

    if @appointment.update(
      permitted_attributes(@appointment)
    )
      redirect_to @appointment,
                  notice: "Appointment was successfully updated."
    else
      render :edit,
             status: :unprocessable_entity
    end
  end

  def destroy
    authorize @appointment

    @appointment.destroy

    redirect_to appointments_path,
                notice: "Appointment was successfully deleted."
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end