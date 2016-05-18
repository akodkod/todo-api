class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.belongs_to :user, foreign_key: true, index: true

      t.string :text
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
