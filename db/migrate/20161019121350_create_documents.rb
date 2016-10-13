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

      t.timestamps
    end
  end
end
