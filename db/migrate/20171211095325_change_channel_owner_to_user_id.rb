class ChangeChannelOwnerToUserId < ActiveRecord::Migration[5.1]
  def change
    rename_column :channels, :owner, :user_id
  end
end
