# frozen_string_literal: true
class CreateSubModules < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_modules do |t|
      t.string :name
      t.integer :lecture_count
      t.integer :labs_count
      t.references :main_module, foreign_key: true, null: false

      t.timestamps
    end
  end
end
