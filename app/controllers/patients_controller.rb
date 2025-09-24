class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :update, :destroy]

  # GET /patients
  def index
    q = Patient.all
    if params[:full_name].present?
      name = params[:full_name].strip.downcase
      q = q.where("LOWER(first_name) LIKE :s OR LOWER(last_name) LIKE :s OR LOWER(middle_name) LIKE :s", s: "%#{name}%")
    end

    if params[:gender].present?
      q = q.where(gender: params[:gender])
    end

    if params[:start_age].present? || params[:end_age].present?
      today = Date.current
      if params[:start_age].present?
        max_birthday = today - params[:start_age].to_i.years
        q = q.where("birthday <= ?", max_birthday)
      end
      if params[:end_age].present?
        min_birthday = today - params[:end_age].to_i.years
        q = q.where("birthday >= ?", min_birthday)
      end
    end

    limit = (params[:limit] || 20).to_i
    offset = (params[:offset] || 0).to_i

    patients = q.limit(limit).offset(offset)
    render json: patients.as_json(include: :doctors)
  end

  def show
    render json: @patient.as_json(include: :doctors)
  end

  def create
    patient = Patient.new(patient_params)
    if patient.save
      assign_doctors(patient)
      render json: patient.as_json(include: :doctors), status: :created
    else
      render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @patient.update(patient_params)
      assign_doctors(@patient)
      render json: @patient.as_json(include: :doctors)
    else
      render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
    head :no_content
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :middle_name, :birthday, :gender, :height, :weight)
  end

  # doctors_ids: array of doctor ids
  def assign_doctors(patient)
    return unless params[:doctor_ids].present?
    ids = params[:doctor_ids].map(&:to_i).uniq
    patient.doctor_ids = ids
  end
end
