# frozen_string_literal: true
class CreateLabs < ActiveRecord::Migration[5.0]
  def change
    create_table :labs do |t|
      t.string :name
      t.integer :time_count
      t.integer :position

      t.references :document, foreign_key: true, null: false

      t.timestamps
    end
  end
end
