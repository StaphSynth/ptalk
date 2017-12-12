class AddSlugsToChannels < ActiveRecord::Migration[5.1]
  def change
    add_column :channels, :slug, :string, unique: true
  end
end
