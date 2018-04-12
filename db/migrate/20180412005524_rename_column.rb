class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :todo_items, :due_date, :due_at
  end
end
