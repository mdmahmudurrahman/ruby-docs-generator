# frozen_string_literal: true
class AddFieldsToDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :cathedra_name, :string
    add_column :documents, :groups_codes, :string
  end
end
