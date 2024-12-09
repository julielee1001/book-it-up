class AddGoogleIdToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :google_id, :string
  end
end
