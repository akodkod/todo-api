class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name,      default: nil
      t.string :last_name,       default: nil
      t.string :email,           null: false, default: ''
      t.string :password_digest, null: false, default: ''
      t.string :api_key,         null: false

      t.timestamps
    end

    add_index :users, :email,   unique: true
    add_index :users, :api_key, unique: true
  end
end
