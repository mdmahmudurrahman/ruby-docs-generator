# frozen_string_literal: true
class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :name
      t.integer :lecture_count
      t.integer :labs_count
      t.references :sub_module, foreign_key: true, null: false

      t.timestamps
    end
  end
end
