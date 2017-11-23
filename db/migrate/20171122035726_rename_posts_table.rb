class RenamePostsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :posts, :messages
  end
end
