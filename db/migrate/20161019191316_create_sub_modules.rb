# frozen_string_literal: true
class CreateSubModules < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_modules do |t|
      t.string :name
      t.integer :labs_time
      t.integer :lectures_time

      t.references :main_module, foreign_key: true, null: false

      t.timestamps
    end
  end
end
