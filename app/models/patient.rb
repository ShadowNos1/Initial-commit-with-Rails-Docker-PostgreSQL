class Patient < ApplicationRecord
  has_many :doctors_patients, dependent: :destroy
  has_many :doctors, through: :doctors_patients
  has_many :bmr_records, dependent: :destroy

  validates :first_name, :last_name, :birthday, :gender, :height, :weight, presence: true
  validates :weight, numericality: { greater_than: 0 }
  validates :height, numericality: { greater_than: 0 }
end
