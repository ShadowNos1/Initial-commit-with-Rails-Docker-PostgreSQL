class BmiController < ApplicationController
  # POST /bmi
  # body: { height: <cm>, weight: <kg> }  OR /patients/:patient_id/bmi to use patient data
  def calculate
    if params[:patient_id]
      patient = Patient.find(params[:patient_id])
      height = patient.height
      weight = patient.weight
    else
      height = params.require(:height)
      weight = params.require(:weight)
    end

    client = BmiClient.new
    result = client.calculate(height_cm: height, weight_kg: weight)
    render json: result
  end
end
