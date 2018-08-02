class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :card_id
      t.text :content
      t.integer :parent_id

      t.timestamps
    end
    add_index :comments, :card_id
  end
end
