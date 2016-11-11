class AddProtocolsToDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :head_of_department, :string
    add_column :documents, :program_department_approved_date, :string

    add_column :documents, :head_of_commission, :string
    add_column :documents, :program_commission_approved_date, :string

    add_column :documents, :head_of_academic_council, :string
    add_column :documents, :program_academic_council_approved_date, :string
  end
end
