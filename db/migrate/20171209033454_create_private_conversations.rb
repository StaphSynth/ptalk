class CreatePrivateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :private_conversations do |t|
      t.integer :channel_id
      t.integer :user_id
      t.timestamps
    end
  end
end
