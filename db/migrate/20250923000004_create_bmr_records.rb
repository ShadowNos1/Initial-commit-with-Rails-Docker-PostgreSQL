class CreateBmrRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :bmr_records do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :formula, null: false
      t.decimal :value, precision: 8, scale: 2, null: false
      t.datetime :calculated_at, null: false
      t.timestamps
    end
  end
end
