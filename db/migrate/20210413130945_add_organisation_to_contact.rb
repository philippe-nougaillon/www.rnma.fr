class AddOrganisationToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :organisation, :string
  end
end
