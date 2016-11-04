# frozen_string_literal: true
class CreateScientists < ActiveRecord::Migration[5.0]
  def change
    create_table :scientists do |t|
      t.string :name
      t.string :position

      t.references :document, foreign_key: true, null: false

      t.timestamps
    end
  end
end
