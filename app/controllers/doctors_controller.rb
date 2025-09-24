class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :update, :destroy]

  def index
    limit = (params[:limit] || 20).to_i
    offset = (params[:offset] || 0).to_i
    doctors = Doctor.limit(limit).offset(offset)
    render json: doctors.as_json(include: :patients)
  end

  def show
    render json: @doctor.as_json(include: :patients)
  end

  def create
    d = Doctor.new(doctor_params)
    if d.save
      render json: d, status: :created
    else
      render json: { errors: d.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @doctor.update(doctor_params)
      render json: @doctor
    else
      render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @doctor.destroy
    head :no_content
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :middle_name)
  end
end
