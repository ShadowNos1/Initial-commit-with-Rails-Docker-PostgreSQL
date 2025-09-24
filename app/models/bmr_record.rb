class BmrRecord < ApplicationRecord
  belongs_to :patient
  validates :formula, :value, :calculated_at, presence: true
end
