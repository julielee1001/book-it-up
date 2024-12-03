class CreateLists < ActiveRecord::Migration[7.2]
  def change
    create_table :lists do |t|
      t.string :name
      t.text :description
      t.integer :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
