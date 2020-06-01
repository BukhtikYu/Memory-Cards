class AddUserIdToImport < ActiveRecord::Migration[6.0]
  def change
    add_column :imports, :user_id, :bigint
  end
end
