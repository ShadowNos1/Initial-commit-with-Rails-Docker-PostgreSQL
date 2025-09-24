Rails.application.routes.draw do
  resources :doctors, only: [:index, :show, :create, :update, :destroy]
  resources :patients do
    resources :bmr, controller: "bmr_records", only: [:index, :create]
  end

  post "/bmi", to: "bmi#calculate"
  post "/patients/:patient_id/bmi", to: "bmi#calculate"

  # optional swagger route if added later:
  # mount Rswag::Ui::Engine => '/api-docs'
end
