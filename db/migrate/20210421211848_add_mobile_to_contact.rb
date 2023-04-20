class AddMobileToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :mobile, :string
  end
end
