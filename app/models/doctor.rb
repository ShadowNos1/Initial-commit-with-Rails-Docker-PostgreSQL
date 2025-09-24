class Doctor < ApplicationRecord
  has_many :doctors_patients, dependent: :destroy
  has_many :patients, through: :doctors_patients

  validates :first_name, :last_name, presence: true
end
