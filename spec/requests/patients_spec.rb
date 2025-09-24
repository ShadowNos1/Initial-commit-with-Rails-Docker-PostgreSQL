require "rails_helper"

RSpec.describe "Patients API", type: :request do
  let!(:doctor) { Doctor.create!(first_name: "Ivan", last_name: "Petrov") }
  it "creates patient and assigns doctor" do
    post "/patients", params: { patient: { first_name: "P", last_name: "L", birthday: "1990-01-01", gender: "male", height: 180, weight: 80 }, doctor_ids: [doctor.id] }
    expect(response).to have_http_status(:created)
    json = JSON.parse(response.body)
    expect(json["doctors"].first["id"]).to eq(doctor.id)
  end
end
