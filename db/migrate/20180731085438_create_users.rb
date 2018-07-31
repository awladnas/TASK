class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest
      t.string :role
      t.string :token

      t.timestamps
    end
    add_index :users, :email
  end
end
