class ChangeChannelPublicToParamToPrivate < ActiveRecord::Migration[5.1]
  def change
    change_column_default :channels, :public, false
    rename_column :channels, :public, :private
  end
end
