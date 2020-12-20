class AddDefaultToOnline < ActiveRecord::Migration[6.1]
  def change
    change_column :vendors, :online, :boolean, default: true
  end
end
