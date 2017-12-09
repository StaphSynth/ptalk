class AddPublicToChannel < ActiveRecord::Migration[5.1]
  def change
    add_column :channels, :public, :boolean, { default: true }
  end
end
