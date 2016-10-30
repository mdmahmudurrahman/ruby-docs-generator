# frozen_string_literal: true
class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :discipline_code
      t.string :discipline_name
      t.string :field_of_study_code
      t.string :field_of_study_name
      t.string :speciality_name
      t.string :specialization_name
      t.string :faculty_name
      t.string :type_of_control

      t.integer :labs_count
      t.integer :credits_count
      t.integer :lectures_count
      t.integer :semester_number
      t.integer :year_of_studying
      t.integer :self_hours_count
      t.integer :total_hours_count

      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
