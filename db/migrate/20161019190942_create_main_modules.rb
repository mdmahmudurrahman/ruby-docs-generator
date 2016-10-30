# frozen_string_literal: true
class CreateMainModules < ActiveRecord::Migration[5.0]
  def change
    create_table :main_modules do |t|
      t.string :name
      t.integer :total_time
      t.references :document, foreign_key: true, null: false

      t.timestamps
    end
  end
end
