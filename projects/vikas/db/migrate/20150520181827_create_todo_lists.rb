class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :title
      t.text :desc

      t.timestamps
    end
  end
end
