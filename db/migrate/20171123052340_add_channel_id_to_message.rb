class AddChannelIdToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :channel_id, :integer
  end
end
