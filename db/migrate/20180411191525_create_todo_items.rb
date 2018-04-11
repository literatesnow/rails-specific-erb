class CreateTodoItems < ActiveRecord::Migration[5.2]
  def change
    create_table :todo_items do |t|
      t.string :title
      t.text :text
      t.timestamp :due_date

      t.timestamps
    end
  end
end
