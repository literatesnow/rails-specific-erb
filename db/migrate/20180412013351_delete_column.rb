class DeleteColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :todo_items, :completed_at
  end
end
