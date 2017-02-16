class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :reset_password_token

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :role
    add_index :users, :reset_password_token
  end
end
