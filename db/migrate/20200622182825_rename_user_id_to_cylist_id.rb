class RenameUserIdToCylistId < ActiveRecord::Migration[6.0]
  def change
    rename_column :rides, :user_id, :cyclist_id
  end
end
