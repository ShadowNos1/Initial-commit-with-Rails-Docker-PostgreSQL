class BmrRecordsController < ApplicationController
  before_action :set_patient

  # POST /patients/:patient_id/bmr
  # params: { formula: "mifflin" | "harris" }
  def create
    formula = params.require(:formula)
    value = BmrService.calculate(@patient, formula)
    record = @patient.bmr_records.create!(formula: formula, value: value, calculated_at: Time.current)
    render json: record, status: :created
  rescue ArgumentError => e
    render json: { error: e.message }, status: :bad_request
  end

  # GET /patients/:patient_id/bmr
  def index
    limit = (params[:limit] || 20).to_i
    offset = (params[:offset] || 0).to_i
    records = @patient.bmr_records.order(created_at: :desc).limit(limit).offset(offset)
    render json: records
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end
end
