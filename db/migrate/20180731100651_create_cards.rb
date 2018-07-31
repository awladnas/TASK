class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :title
      t.text :description
      t.integer :created_by
      t.integer :list_id

      t.timestamps
    end
  end
end
